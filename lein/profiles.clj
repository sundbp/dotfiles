{:user {:plugins [[lein-pprint "1.1.1"]
                  [lein-immutant "1.1.1"]
                  [lein-ancient "0.4.2"]]
        :dependencies [[org.clojure/tools.nrepl "0.2.3"]
                       [slamhound "1.5.0"]
                       [nrepl-inspect "0.4.1"]
                       [io.aviso/pretty "0.1.8"]
                       [repetition-hunter "1.0.0"]
                       [spyscope "0.1.4"]]
        :injections [(require 'spyscope.core)]
        :repl-options {:nrepl-middleware [inspector.middleware/wrap-inspect
                                          io.aviso.nrepl/pretty-middleware]}
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
