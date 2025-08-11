open Conkeldurr

let%expect_test "parse string headers" =
  let header = "(String abc)" in
  header |> Header.Parser.parse |> Header.T.to_string |> print_endline;
  [%expect {| abc: string; |}]
;;

let%expect_test "parse float headers" =
  let header = "(Float abc)" in
  header |> Header.Parser.parse |> Header.T.to_string |> print_endline;
  [%expect {| abc: number; |}]
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

let%expect_test "parse headers from csv string" =
  let csv =
    Spreadsheet.Csv0.from_string
      {|
      (String a),(String b),(String c),(Float ab),(Integer bc),(Boolean cd)
      A,B,C,1.0,2,false
      D,E,F,3.1,33,true
      |}
  in
  csv.headers |> Header.sexp_of_t |> Sexplib.Sexp.to_string |> print_endline;
  [%expect {| ((String a)(String b)(String c)(Float ab)(Integer bc)(Boolean cd)) |}]
;;

let%expect_test "parse headers from csv file" =
  let csv = Spreadsheet.Csv0.from_path "./cases/data/sample_spreadsheet.csv" in
  csv.headers |> Header.sexp_of_t |> Sexplib.Sexp.to_string |> print_endline;
  [%expect {| ((String a)(String b)(String c)(Float ab)(Integer bc)(Boolean cd)) |}]
;;
