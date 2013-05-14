{:user {:plugins [[lein-pprint "1.1.1"]
                  [lein-immutant "0.17.1"]]
        :dependencies [[org.clojure/tools.nrepl "0.2.2"]
                       [slamhound "1.3.1"]]
        :aliases {"slamhound" ["run" "-m" "slam.hound"]}
        :mirrors {"central" {:name "central-proxy"
                             :url "http://nexus.vlan.tuloscapital.com:8081/nexus/content/repositories/central/"}
                  #"clojars" {:name "clojars-proxy"
                              :url "http://nexus.vlan.tuloscapital.com:8081/nexus/content/repositories/clojars/"}}}}
