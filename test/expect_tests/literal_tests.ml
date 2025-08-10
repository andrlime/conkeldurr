let%expect_test "literal sample test" =
  print_endline "5";
  [%expect {| 5 |}]
;;
