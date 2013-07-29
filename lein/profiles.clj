{:user {:plugins [[lein-pprint "1.1.1"]
                  [lein-immutant "1.0.0"]
                  [lein-ancient "0.4.2"]]
        :dependencies [[org.clojure/tools.nrepl "0.2.3"]
                       [slamhound "1.3.3"]
                       [nrepl-inspect "0.3.0"]]
        :repl-options {:nrepl-middleware [inspector.middleware/wrap-inspect]}
        :aliases {"slamhound" ["run" "-m" "slam.hound"]}
        :mirrors {"central" {:name "central-proxy"
                            :url "http://nexus.vlan.tuloscapital.com:8081/nexus/content/repositories/central/"}
                 #"clojars" {:name "clojars-proxy"
                             :url "http://nexus.vlan.tuloscapital.com:8081/nexus/content/repositories/clojars/"}}
        :deploy-repositories [["snapshots" {:url "http://nexus.vlan.tuloscapital.com:8081/nexus/content/repositories/snapshots/"
                                            :update :always}]
                              ["releases" {:url "http://nexus.vlan.tuloscapital.com:8081/nexus/content/repositories/releases/"
                                           :update :always}]]
        }}
