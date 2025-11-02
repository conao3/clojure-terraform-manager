(ns conao3.terraform-manager
  (:gen-class)
  (:require
   [clojure.tools.logging :as log]))

(defn -main [& args]
  (println "terraform-manager" args)
  (let [command (first args)]
    (case command
      "switch" (do
                 (log/info "Executing switch command")
                 (println "Switch functionality not yet implemented"))
      (do
        (log/info "Unknown command:" command)
        (println "Usage: terraform-manager <command>")
        (println "Commands:")
        (println "  switch - Switch terraform configuration")))))
