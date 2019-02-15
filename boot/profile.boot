(require 'boot.repl)

(swap! boot.repl/*default-dependencies*
       concat '[[cider/cider-nrepl "0.20.1-SNAPSHOT"]
                [refactor-nrepl "2.4.0"]])

(swap! boot.repl/*default-middleware*
       concat ['refactor-nrepl.middleware/wrap-refactor
               'cider.nrepl/cider-middleware])


;; Get credentials from a ccrypt encrypted file.
(configure-repositories!
 (let [sh-res (clojure.java.shell/sh "ccat"
                                     "--keyfile"
                                     (str (boot.App/bootdir) "/enckey")
                                     (str (boot.App/bootdir) "/credentials.edn.cpt"))
       creds-data (if (zero? (:exit sh-res))
                    (-> sh-res :out clojure.edn/read-string)
                    {})]
   (fn [{:keys [url] :as repo-map}]
     (merge repo-map (get creds-data url)))))

;; (set-env! :dependencies #(conj % '[jsofra/data-scope "0.1.3-SNAPSHOT"]))
;; (boot.core/load-data-readers!)
;; (require 'data-scope.charts)
;; (require 'data-scope.graphs)
;; (require 'data-scope.inspect)
;; (require 'data-scope.pprint)

;; (set-env! :repositories #(concat % [["snapshots"
;;                                      {:url "http://10.10.10.5:8081/artifactory/libs-snapshot-local/"
;;                                       :update :always}]
;;                                     ["releases"
;;                                      {:url "http://10.10.10.5:8081/artifactory/libs-release-local/"
;;                                       :update :always}]]))
