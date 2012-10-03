(setq clojure-swank-command
      (if (or (locate-file "lein" exec-path) (locate-file "lein.bat" exec-path))
          "lein ritz-in %s"
        "echo \"lein ritz-in %s\" | $SHELL -l"))
