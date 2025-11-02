#_{:clj-kondo/ignore [:unused-referred-var]}
(ns dev
  (:require
   [clojure.main :as clojure.main]))

(apply require clojure.main/repl-requires)
