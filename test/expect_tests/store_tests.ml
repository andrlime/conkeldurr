let%expect_test "store sample test" =
  print_endline "5";
  [%expect {| 5 |}]
;;
