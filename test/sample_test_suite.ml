open OUnit2
open Helper

let test_addition _ = assert_equal 2 (1 + 1)
let test_addition_broken _ = assert_equal 2 (1 + 3)

let suite =
  "Basic math tests"
  >::: [ test "1 + 1 = 2" test_addition; test "DISABLED 1 + 1 = 4" test_addition_broken ]
;;
