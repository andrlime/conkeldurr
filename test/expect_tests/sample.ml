let%expect_test "example" =
  print_endline "5";
  [%expect {| 5 |}]
;;
