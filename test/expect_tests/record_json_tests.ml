open Conkeldurr

let%expect_test "print basic JSON rows from csv" =
  let csv =
    Spreadsheet.Csv0.from_string
      {|
      (String a),(String b),(String c),(Float ab),(Integer bc),(Boolean cd)
      A,B,C,1.0,2,false
      D,E,F,3.1,33,true
      |}
  in
  csv |> Spreadsheet.Csv0.get_json "foo" "bar" |> print_endline;
  [%expect
    {|
    export const foo: Array<bar> = [
    { a: "A", b: "B", c: "C", ab: 1., bc: 2, cd: false },
    { a: "D", b: "E", c: "F", ab: 3.1, bc: 33, cd: true }
    ];
  |}];
  csv |> Spreadsheet.Csv0.get_interface "foo" |> print_endline;
  [%expect
    {|
    export interface foo {
    a: string;
    b: string;
    c: string;
    ab: number;
    bc: number;
    cd: boolean;
    };
  |}]
;;

let%expect_test "fails on duplicate columns" =
  try
    ignore
      (Spreadsheet.Csv0.from_string
         {|
      (String a),(String a)
      A,A
      |})
  with
  | Failure msg ->
    print_endline msg;
    [%expect
      {|
  Cannot have duplicate columns
  |}]
;;
