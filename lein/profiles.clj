{:user {:plugins [[lein-pprint "1.1.1"]
                  [lein-immutant "0.17.1"]]
        :dependencies [[org.clojure/tools.nrepl "0.2.2"]
                       [slamhound "1.3.1"]]
        :aliases {"slamhound" ["run" "-m" "slam.hound"]}
        :repositories
        [["snapshots" {:url "http://nexus.vlan.tuloscapital.com:8081/nexus/content/repositories/snapshots/"
                       :update :always}]
         ["releases" {:url "http://nexus.vlan.tuloscapital.com:8081/nexus/content/repositories/releases/"
                      :update :always}]]
        :mirrors {"central" {:name "Internal nexus mirror of central"
                             :url "http://nexus.vlan.tuloscapital.com:8081/nexus/content/repositories/central/"}
                  #"clojars" {:name "Internal nexus mirror of clojars"
                              :url "http://nexus.vlan.tuloscapital.com:8081/nexus/content/repositories/clojars/"}}}}
