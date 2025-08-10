let%expect_test "interpreter sample test" =
  print_endline "5";
  [%expect {| 5 |}]
;;
