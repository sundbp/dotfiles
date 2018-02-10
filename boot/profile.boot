(require 'boot.repl)

(swap! boot.repl/*default-dependencies*
       concat '[[cider/cider-nrepl "0.17.0-SNAPSHOT"]
                [refactor-nrepl "2.4.0-SNAPSHOT"]])

(swap! boot.repl/*default-middleware*
       concat ['refactor-nrepl.middleware/wrap-refactor
               'cider.nrepl/cider-middleware])

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

;; Get credentials from a GPG encrypted file.
;; (import java.io.File)
;; (try
;;   (configure-repositories!
;;    (let [creds-file (File. (boot.App/bootdir) "credentials.gpg")
;;          creds-data (gpg-decrypt creds-file :as :edn)]
;;      (fn [{:keys [url] :as repo-map}]
;;        (merge repo-map (creds-data url)))))
;;   (catch Throwable _
;;     nil))
