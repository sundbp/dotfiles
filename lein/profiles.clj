{:user {:plugins [[lein-ancient "0.4.2" :exclusions [org.clojure/clojure commons-codec]]
                  [cider/cider-nrepl "0.8.2"]
                  [refactor-nrepl "0.2.2"]]
        :dependencies [[slamhound "1.5.5"]
                       [spyscope "0.1.5"]]
        :injections [(require 'spyscope.core)]
        :aliases {"slamhound" ["run" "-m" "slam.hound"]}
        :mirrors {"central" {:name "central-proxy"
                           :url "http://nexus.vlan.tuloscapital.com:8081/nexus/content/repositories/central/"}
                 "clojars" {:name "clojars-proxy"
                            :url "http://nexus.vlan.tuloscapital.com:8081/nexus/content/repositories/clojars/"}}
        :deploy-repositories [["snapshots" {:url "http://nexus.vlan.tuloscapital.com:8081/nexus/content/repositories/snapshots/"
                                            :username "tulos"
                                            :password "tulos123"}]
                              ["releases" {:url "http://nexus.vlan.tuloscapital.com:8081/nexus/content/repositories/releases/"
                                           :username "tulos"
                                           :password "tulos123"}]]}}
