#!/usr/bin/env planck
;; NOTE: to run this script please install the planck REPL
;;  Instructions can be found here: http://planck-repl.org/
(ns sundbp.count-instances
  (:require [planck.core]
            [planck.shell :as shell]
            [goog.string :as gstring]
            [goog.string.format]
            [cljs.reader :as reader]
            [cljs.pprint :as pprint]))

(defn- sh
  [cmd]
  (apply shell/sh (clojure.string/split cmd #"\s+")))


(defn- parse-docker-datetime
  "Parse the test returned by docker format .CreatedAt into a JS Date.
  It doesn't explicitly deal with timezones, but it shouldn't really matter
  for the case at hand."
  [dt-str]
  (let [parts (clojure.string/split dt-str #"\s")
        date-parts (clojure.string/split (first parts) #"\-")
        time-parts (clojure.string/split (second parts) #"\:")]
    (js/Date. (js/parseInt (nth date-parts 0))
              (js/parseInt (nth date-parts 1))
              (js/parseInt (nth date-parts 2))
              (js/parseInt (nth time-parts 0))
              (js/parseInt (nth time-parts 0))
              (js/parseInt (nth time-parts 1))
              (js/parseInt (nth time-parts 2))
              0)))

(def app-servers ["10.11.1.101"
                  "10.11.1.102"
                  "10.11.1.103"
                  ;;"10.11.2.101"
                  "10.11.2.102"
                  "10.11.2.103"
                  "10.11.3.101"
                  "10.11.3.102"
                  "10.11.3.103"
                  ])

(defn- find-instances-by-host
  [servers]
  (->> servers
       (map (fn [h]
              [h
               (->> (sh
                     (gstring/format
                      "ssh %s docker ps --format '{:id \"{{.ID}}\" :image \"{{.Image}}\" :created-at \"{{.CreatedAt}}\" :name \"{{.Names}}\"}'" h))
                    :out
                    (gstring/format "[%s]")
                    reader/read-string)]))
       (map (fn [[h cs]]
              [h (->> cs
                      (filter #(re-matches #".*wps-multi.*" (:image %)))
                      (map (fn [c] (-> c
                                       (update-in [:created-at] parse-docker-datetime)
                                       (assoc :host h)))
                           cs))]))
       (into {})))

(def instances-by-host (find-instances-by-host app-servers))

(def instances (mapcat second instances-by-host))


(defn- rolling-reboot-time
  [d]
  (doto d
    (.setHours 4)
    (.setMinutes 0)
    (.setSeconds 0)))

(defn- print-instance-info
  [hs]
  (doseq [[h cs] hs]
    (println (gstring/format "num containers on %s is %d" h (count cs))))

  (println (gstring/format "total number of containers is %d"
                           (reduce (fn [tot [_ cs]]
                                     (+ tot (count cs)))
                                   0
                                   hs))))


(println "Running instances:")
(print-instance-info instances-by-host)


(let [cutoff (rolling-reboot-time (js/Date.))
      filtered (->> instances-by-host
                    (map (fn [[h cs]]
                           [h (->> cs
                                   (sort-by :created-at (fn [t1 t2] (< t1 t2)))
                                   (filter (fn [c] (> (:created-at c) cutoff))))]))
                    (into {}))]
  (println (gstring/format "\nAfter filtering out all instances started before %s" cutoff))
  (print-instance-info filtered))

(def instances-by-name
  (->> instances
       (group-by (fn [i]
                   (-> (clojure.string/split (:name i) #"\_")
                       first)))))


(def duplicates-by-name
  (->> instances-by-name
       (filter (fn [[_ is]] (< 1 (count is))))
       (into {})))


(defn- stale-containers
  [cs]
  (->> cs
       (sort-by :created-at (fn [t1 t2] (> t1 t2)))
       rest))


(defn- kill-zombie
  [z]
  (println (gstring/format "killing %s on host %s.." (:name z) (:host z)))
  (println (sh (gstring/format "ssh %s sudo docker rm -f %s"
                               (:host z) (:name z)))))


(println "\nThese client code names have more than 1 container running: (name, num instances)")
(doseq [[n cs] duplicates-by-name]
  (println (gstring/format "%24s %d (containers to kill %s)"
                           n
                           (count cs)
                           (->> (stale-containers cs)
                                (map (fn [c] (gstring/format "%s @ %s" (:name c) (:host c))))
                                (clojure.string/join ", ")))))

(let [zombies (->> duplicates-by-name
                   (mapcat (fn [[_ cs]] (stale-containers cs))))]
  (println (gstring/format "\nNum extra containers we can kill in total: %d"
                           (count zombies)))
  (println "\nGo ahead and kill these zombie containers? [y/N]")
  (let [input (planck.core/read-line)]
    (when (= "y" (clojure.string/lower-case input))
      (doseq [z zombies]
        (kill-zombie z)))))

(println "\nRefetch info and print table of running instances? [Y/n]")
(let [input (planck.core/read-line)]
  (when-not (= "n" (clojure.string/lower-case input))
    (let [is (->> (find-instances-by-host app-servers)
                  (mapcat second)
                  (sort-by :name))]
      (pprint/print-table [:name :host :image :id :created-at] is)
      (println (gstring/format "\nTotal instances: %d" (count is))))))
