#!/usr/bin/env planck
;; NOTE: to run this script please install the planck REPL
;;  Instructions can be found here: http://planck-repl.org/
(ns bi.branch-cleanup
  (:require [planck.core]
            [planck.shell :as shell]
            [goog.string :as gstring]
            [goog.string.format]
            [goog.date])
  (:import goog.date.DateTime))

(defn- sh
  [cmd]
  (apply shell/sh (clojure.string/split cmd #"\s+")))

(defn- get-branches
  [cmd]
  (->> (:out (sh cmd))
       clojure.string/split-lines
       (map clojure.string/trim)))

(defn- get-merged-for
  [target]
  (get-branches (gstring/format "git branch -r --merge %s" target)))

(def merge-targets #{"origin/develop"
                     "origin/master"
                     "origin/staging"
                     "origin/frozen"
                     "origin/tranche2"
                     "origin/tranche3"
                     "origin/tranche4"
                     "origin/test"
                     "origin/test1"
                     "origin/demo"
                     "origin/release/staging"
                     "origin/release/6.25.0"
                     "origin/release/6.26.0"
                     "origin/release/6.26.1"
                     "origin/release/6.27.0"
                     "origin/release/6.27.1"
                     "origin/release/6.27.2"
                     "origin/release/6.27.3"
                     "origin/release/6.27.4"
                     "origin/release/6.28"
                     "origin/release/6.29"
                     "origin/release/6.30"
                     "origin/release/6.31"
                     "origin/release/6.32"})

(println "Pruning remote origin:\n" (sh "git remote prune origin") "\n\n")

(def all-merged (-> (mapcat get-merged-for merge-targets)
                    (->> (into #{}))
                    (clojure.set/difference (clojure.set/union merge-targets #{"origin/HEAD -> origin/develop"}))))

(def all-branches (->> (get-branches "git branch -r")
                       (into #{})))

(def all-unmerged (clojure.set/difference all-branches all-merged merge-targets #{"origin/HEAD -> origin/develop"}))

(println (gstring/format "Total branches at origin:    %d" (count all-branches)))
(println (gstring/format "Merged branches at origin:   %d" (count all-merged)))
(println (gstring/format "Unmerged branches at origin: %d" (count all-unmerged)))

(defn- remove-origin
  [branch]
  (-> branch
      (clojure.string/split #"/")
      rest
      (->> (clojure.string/join "/"))))

(def protected-branches
  #{"origin/PRTL-1800"
    "origin/feature/PRTL-1905"
    "origin/feature/boardid"
    "origin/boardid"
    "origin/feature/PRTL-1441"})

(defn- delete-branches
  [branches-to-delete]
  (println "Deleting branches..")
  (doseq [branches (partition-all 10 (sort branches-to-delete))]
    (let [filtered (remove protected-branches branches)]
      (doseq [b filtered] (println b))
      (let [res (sh (gstring/format "git push origin --delete %s" (->> (map remove-origin filtered)
                                                                       (map #(gstring/format "refs/heads/%s" %))
                                                                       (clojure.string/join " "))))]
        (when-not (zero? (:exit res))
          (println "Error deleting branches" filtered "stdout was:" (:out res) "and stderr was:" (:err res)))))))

(println "\n\nPrint a detailed list of all merged branches? [Y/n]")
(let [input (planck.core/read-line)]
  (when-not (= "n" (clojure.string/lower-case input))
    (println (gstring/format "All merged branches:\n%s" (clojure.string/join "\n" (sort all-merged))))

    (println "\nProtected branches:")
    (println protected-branches)

    (println "\n\nGo ahead and delete all merged branches? (protected braches will not be deleted) [y/N]")
    (let [input (planck.core/read-line)]
      (when (= "y" (clojure.string/lower-case input))
        (println "Deleting merged branches..")
        (delete-branches all-merged)))))

(defn- get-last-activity-info
  [branch]
  (let [res (sh (gstring/format "%s %s" "git show --format=%cI|%s" branch))]
    (assert (zero? (:exit res)) (gstring/format "Couldn't get last activity info for: %s (error = %s)"
                                                branch
                                                (:err res)))
    (let [[timestamp comment] (-> (:out res)
                                  clojure.string/split-lines
                                  first
                                  (clojure.string/split #"\|"))]
      {:branch branch
       :timestamp (js/Date. timestamp)
       :comment comment})))

(defn- n-months-ago
  [d n]
  ;; note: this works for wrapping around to negative dates
  ;; (shown here: https://stackoverflow.com/questions/7937233/how-do-i-calculate-the-date-in-javascript-three-months-prior-to-today)
  (doto d
    (.setMonth (- (.getMonth d) n))))

(def months-grace 2)

(println (gstring/format "\n\nPrint a detailed list of unmerged branches older than %s months? [Y/n]", months-grace))
(let [input (planck.core/read-line)]
  (when-not (= "n" (clojure.string/lower-case input))
    (let [branch-infos (doall (map get-last-activity-info all-unmerged))
          cutoff (n-months-ago (js/Date.) months-grace)
          filtered-branches (->> branch-infos
                                 (sort-by :timestamp (fn [t1 t2] (< t1 t2)))
                                 (filter (fn [i] (< (:timestamp i) cutoff))))]
      (println "All unmerged branches (ordered by activity, oldest activity first):")
      (doseq [info filtered-branches]
        (println (gstring/format "%-55s%s\n\t%s"
                                 (:branch info)
                                 (.toISOString (:timestamp info))
                                 (:comment info))))
      (println (gstring/format "\nFound %d branches with no activity in the last %d months."
                               (count filtered-branches)
                               months-grace))

      (println "\nProtected branches:")
      (println protected-branches)

      (println "\nGo ahead and delete these branches? (protected branches will not be deleted) [y/N]")
      (let [input (planck.core/read-line)]
        (when (= "y" (clojure.string/lower-case input))
          (delete-branches (map :branch filtered-branches)))))))

(println "\ndone.")
