{:user {:plugins [[lein-ritz "0.6.0"]
                  [lein-pedantic "0.0.3"]
                  [lein-localrepo "0.4.1"]
                  [lein-pprint "1.1.1"]
                  [lein-immutant "0.11.0"]]
        :dependencies [[ritz/ritz-nrepl-middleware "0.6.0"]
                       [ritz/ritz-debugger "0.6.0"]
                       [ritz/ritz-repl-utils "0.6.0"]]
        :repl-options {:nrepl-middleware
                       [ritz.nrepl.middleware.javadoc/wrap-javadoc
                        ritz.nrepl.middleware.simple-complete/wrap-simple-complete]}}
 :jdk1.7 {:resource-paths ["/usr/lib/jvm/jdk1.7.0_10/lib/tools.jar"
                           "/usr/lib/jvm/jdk1.7.0_10/lib/sa-jdi.jar"]}
 :hooks [ritz.add-sources]}
