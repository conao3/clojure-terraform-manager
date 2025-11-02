(ns conao3.terraform-manager-test
  (:require
   [clojure.test :refer [deftest is testing]]
   [conao3.terraform-manager :as sut]))

(deftest main-test
  (testing "main function exists"
    (is (fn? sut/-main))))
