{:repl {:dependencies [[org.clojure/clojure "1.9.0-alpha15"]]
        :repl-options {:timeout 120000}}
 :user {:plugins [[com.billpiel/sayid "0.0.10"]]
        :dependencies [[jsofra/data-scope "0.1.0"]]
        :injections [(require 'data-scope.charts)
                     (require 'data-scope.graphs)
                     (require 'data-scope.inspect)
                     (require 'data-scope.pprint)]
        :deploy-repositories [
                              ;; ["snapshots" {:url "http://artifactory.default.svc.cluster.local/artifactory/libs-snapshot-local/"
                              ;;               :username "admin"}]
                              ;; ["releases" {:url "http://artifactory.default.svc.cluster.local/artifactory/libs-release-local/"
                              ;;              :username "admin"}]
                              ["releases" {:url "http://10.10.10.5:8081/artifactory/libs-release-local/"
                                           :username "sundbp"}]]
        }}
