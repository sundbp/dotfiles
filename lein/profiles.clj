{:repl {:dependencies [[org.clojure/clojure "1.9.0-RC1"]
                       [jsofra/data-scope "0.1.0"]]
        :repl-options {:timeout 120000}
        :plugins [;;[com.billpiel/sayid "0.0.10"]
                  [cider/cider-nrepl "0.16.0-SNAPSHOT"]
                  [refactor-nrepl "2.4.0-SNAPSHOT"]]
        :injections [(require 'data-scope.charts)
                     (require 'data-scope.graphs)
                     (require 'data-scope.inspect)
                     (require 'data-scope.pprint)]}
 :user {:deploy-repositories [
                              ;; ["snapshots" {:url "http://artifactory.default.svc.cluster.local/artifactory/libs-snapshot-local/"
                              ;;               :username "admin"}]
                              ;; ["releases" {:url "http://artifactory.default.svc.cluster.local/artifactory/libs-release-local/"
                              ;;              :username "admin"}]
                              ["releases" {:url "http://10.10.10.5:8081/artifactory/libs-release-local/"
                                           :username "sundbp"}]
                              ["snapshots" {:url "http://10.10.10.5:8081/artifactory/libs-snapshot-local/"
                                            :username "sundbp"}]]}
 }
