open Conkeldurr

let%expect_test "parse string headers" =
  let header = "(String abc)" in
  header |> Header.Parser.parse |> Header.T.to_string |> print_endline;
  [%expect {| String abc |}]
;;

let%expect_test "parse float headers" =
  let header = "(Float abc)" in
  header |> Header.Parser.parse |> Header.T.to_string |> print_endline;
  [%expect {| Float abc |}]
;;
