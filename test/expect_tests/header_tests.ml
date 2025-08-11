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

let%expect_test "parse multiple headers" =
  let headers = [ "(Float abc)"; "(Float def)"; "(String ghi)" ] in
  headers
  |> Header.Parser.parse_all
  |> Header.sexp_of_t
  |> Sexplib.Sexp.to_string
  |> print_endline;
  [%expect {| ((Float abc)(Float def)(String ghi)) |}]
;;

let%expect_test "parse from csv" =
  let csv =
    Spreadsheet.CsvSpreadsheet.from_string
      {|
      (String a),(String b),(String c),(Float ab),(Integer bc),(Boolean cd)
      A,B,C,1.0,2,false
      D,E,F,3.1,33,true
      |}
  in
  csv.headers |> Header.sexp_of_t |> Sexplib.Sexp.to_string |> print_endline;
  [%expect {| ((String a)(String b)(String c)(Float ab)(Integer bc)(Boolean cd)) |}]
;;
