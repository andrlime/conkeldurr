open OUnit2

let all_tests = "All tests" >::: [ Sample_test_suite.suite ]
let () = run_test_tt_main all_tests
