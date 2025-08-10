open Conkeldurr

let%expect_test "parse string headers" =
  let header = "(String abc)" in
  header
  |> Spreadsheet.Parser.parse_column_header
  |> Spreadsheet.Header.header_to_string
  |> print_endline;
  [%expect {| String abc |}]
;;

let%expect_test "parse float headers" =
  let header = "(Float abc)" in
  header
  |> Spreadsheet.Parser.parse_column_header
  |> Spreadsheet.Header.header_to_string
  |> print_endline;
  [%expect {| Float abc |}]
;;
