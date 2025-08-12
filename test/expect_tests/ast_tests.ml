open Conkeldurr

let%expect_test "parses ReadConstant correctly" =
  let sample_sexp =
    {|
  ((ReadConstant ((var "thing") (value (String "ABCDEF"))))
   (ReadConstant ((var "thing2") (value (Integer 123)))))
  |}
  in
  sample_sexp |> Program.T.of_string |> Program.T.to_readable_string |> print_endline;
  [%expect
    {|
  ReadConstant to variable thing: string
  ReadConstant to variable thing2: number
  |}]
;;

let%expect_test "parses ReadVariable correctly" =
  let sample_sexp =
    {|
  ((ReadVariable ((var "thing") (value (String "ABCDEF"))))
   (ReadVariable ((var "thing2") (value (Integer 123))))
   (ReadVariable ((var "thing3") (value (Float 123)))))
  |}
  in
  sample_sexp |> Program.T.of_string |> Program.T.to_readable_string |> print_endline;
  [%expect
    {|
  ReadVariable to variable thing: string
  ReadVariable to variable thing2: number
  ReadVariable to variable thing3: number
  |}]
;;

let%expect_test "parses ReadSpreadsheet correctly" =
  let sample_sexp =
    {|
  ((ReadSpreadsheet ((var "spreadsheet_123") (interface "INTERFACE_123") (path (Csv "./hello.csv")))))
  |}
  in
  sample_sexp |> Program.T.of_string |> Program.T.to_readable_string |> print_endline;
  [%expect
    {|
  ReadSpreadsheet from path CSV file ./hello.csv to variable spreadsheet_123, interface INTERFACE_123
  |}]
;;

let%expect_test "parses Export correctly" =
  let sample_sexp =
    {|
  ((Export (File "abc.csv"))
   (Export Stdout))
  |}
  in
  sample_sexp |> Program.T.of_string |> Program.T.to_readable_string |> print_endline;
  [%expect
    {|
    Export to file abc.csv
    Export to stdout
    |}]
;;
