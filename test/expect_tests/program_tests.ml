open Conkeldurr

let%expect_test "can interpret simple variable program" =
  let program =
    {|
  ((ReadConstant ((var "thing1") (value (String "ABCDEF"))))
  (ReadVariable ((var "thing2") (value (Integer 123))))
  (ReadConstant ((var "thing3") (value (Integer 123))))
  (ReadConstant ((var "thing5") (value (Float 123))))
  (ReadConstant ((var "thing4") (value (String "hello world"))))
  (Export Stdout))
  |}
  in
  program |> Program.T.of_string |> Interpreter.T.interpret;
  [%expect
    {|
  export const thing1: string = "ABCDEF";
  export const thing3: number = 123;
  export const thing4: string = "hello world";
  export const thing5: number = 123.;
  export let thing2: number = 123;
  |}]
;;

let%expect_test "fails on duplicate variable names" =
  let program =
    {|
  ((ReadConstant ((var "thing1") (value (String "ABCDEF"))))
  (ReadVariable ((var "thing2") (value (Integer 123))))
  (ReadConstant ((var "thing2") (value (String 123))))
  (Export Stdout))
  |}
  in
  try program |> Program.T.of_string |> Interpreter.T.interpret with
  | Failure msg ->
    print_endline msg;
    [%expect {| variable thing2 already set |}]
;;

let%expect_test "fails on duplicate spreadsheet names" =
  let program =
    {|
  ((ReadSpreadsheet ((var "spreadsheet_123") (interface "Interface1") (path (Csv "./cases/data/sample_spreadsheet.csv"))))
  (ReadSpreadsheet ((var "spreadsheet_123") (interface "Interface2") (path (Csv "./cases/data/sample_spreadsheet.csv"))))
  (Export Stdout))
  |}
  in
  try program |> Program.T.of_string |> Interpreter.T.interpret with
  | Failure msg ->
    print_endline msg;
    [%expect {| variable spreadsheet_123 already set |}]
;;

let%expect_test "fails on duplicate interface names" =
  let program =
    {|
  ((ReadSpreadsheet ((var "spreadsheet_123") (interface "Interface1") (path (Csv "./cases/data/sample_spreadsheet.csv"))))
  (ReadSpreadsheet ((var "spreadsheet_456") (interface "Interface1") (path (Csv "./cases/data/sample_spreadsheet.csv"))))
  (Export Stdout))
  |}
  in
  try program |> Program.T.of_string |> Interpreter.T.interpret with
  | Failure msg ->
    print_endline msg;
    [%expect {| variable Interface1 already set |}]
;;

let%expect_test "fails on invalid variable names keywords" =
  [ "1a"; "banana_"; "a$bcd"; "abc123_"; "_"; "$$aa"; "--" ]
  |> List.iter (fun kw ->
    let program =
      Printf.sprintf
        {|
    ((ReadConstant ((var %s) (value (String "ABCDEF")))))
    |}
        kw
    in
    try program |> Program.T.of_string |> Interpreter.T.interpret with
    | Failure msg -> print_endline msg);
  [%expect
    {|
    invalid TypeScript variable name 1a
    invalid TypeScript variable name --
  |}]
;;

let%expect_test "fails on TypeScript keywords" =
  Variable.Keywords.keywords_list
  |> List.iter (fun kw ->
    let program =
      Printf.sprintf
        {|
    ((ReadConstant ((var %s) (value (String "ABCDEF"))))
    (Export Stdout))
    |}
        kw
    in
    try program |> Program.T.of_string |> Interpreter.T.interpret with
    | Failure msg -> print_endline msg);
  [%expect
    {|
  invalid TypeScript variable name abstract
  invalid TypeScript variable name any
  invalid TypeScript variable name as
  invalid TypeScript variable name asserts
  invalid TypeScript variable name async
  invalid TypeScript variable name await
  invalid TypeScript variable name boolean
  invalid TypeScript variable name break
  invalid TypeScript variable name case
  invalid TypeScript variable name catch
  invalid TypeScript variable name class
  invalid TypeScript variable name const
  invalid TypeScript variable name continue
  invalid TypeScript variable name debugger
  invalid TypeScript variable name declare
  invalid TypeScript variable name default
  invalid TypeScript variable name delete
  invalid TypeScript variable name do
  invalid TypeScript variable name else
  invalid TypeScript variable name enum
  invalid TypeScript variable name export
  invalid TypeScript variable name extends
  invalid TypeScript variable name false
  invalid TypeScript variable name finally
  invalid TypeScript variable name for
  invalid TypeScript variable name from
  invalid TypeScript variable name function
  invalid TypeScript variable name get
  invalid TypeScript variable name if
  invalid TypeScript variable name implements
  invalid TypeScript variable name import
  invalid TypeScript variable name in
  invalid TypeScript variable name infer
  invalid TypeScript variable name instanceof
  invalid TypeScript variable name interface
  invalid TypeScript variable name is
  invalid TypeScript variable name keyof
  invalid TypeScript variable name let
  invalid TypeScript variable name module
  invalid TypeScript variable name namespace
  invalid TypeScript variable name never
  invalid TypeScript variable name new
  invalid TypeScript variable name null
  invalid TypeScript variable name number
  invalid TypeScript variable name object
  invalid TypeScript variable name of
  invalid TypeScript variable name package
  invalid TypeScript variable name private
  invalid TypeScript variable name protected
  invalid TypeScript variable name public
  invalid TypeScript variable name readonly
  invalid TypeScript variable name require
  invalid TypeScript variable name return
  invalid TypeScript variable name set
  invalid TypeScript variable name static
  invalid TypeScript variable name string
  invalid TypeScript variable name super
  invalid TypeScript variable name switch
  invalid TypeScript variable name symbol
  invalid TypeScript variable name this
  invalid TypeScript variable name throw
  invalid TypeScript variable name true
  invalid TypeScript variable name try
  invalid TypeScript variable name type
  invalid TypeScript variable name typeof
  invalid TypeScript variable name undefined
  invalid TypeScript variable name unique
  invalid TypeScript variable name unknown
  invalid TypeScript variable name var
  invalid TypeScript variable name void
  invalid TypeScript variable name while
  invalid TypeScript variable name with
  invalid TypeScript variable name yield
  |}]
;;
