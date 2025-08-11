open Conkeldurr

let%expect_test "can import a basic file" =
  let program =
    {|
  ((Import ((var abc) (from banana.ts)))
  (Export Stdout))
  |}
  in
  program |> Program.T.of_string |> Interpreter.T.interpret;
  [%expect
    {|
  import { abc } from "banana.ts";
  |}]
;;

let%expect_test "can import multiple files" =
  let program =
    {|
  (
  (Import ((var abc) (from banana/banana)))
  (Import ((var def) (from abcdef)))
  (Import ((var react) (from react)))
  (Export Stdout))
  |}
  in
  program |> Program.T.of_string |> Interpreter.T.interpret;
  [%expect
    {|
    import { abc } from "banana/banana";
    import { def } from "abcdef";
    import { react } from "react";
    |}]
;;

let%expect_test "can import multiple exports from one file" =
  let program =
    {|
  (
  (Import ((var abc) (from banana/banana)))
  (Import ((var def) (from banana/banana)))
  (Export Stdout))
  |}
  in
  program |> Program.T.of_string |> Interpreter.T.interpret;
  [%expect
    {|
    import { abc } from "banana/banana";
    import { def } from "banana/banana";
    |}]
;;

let%expect_test "fails on importing identical exports" =
  let program =
    {|
  (
  (Import ((var abc) (from banana/banana)))
  (Import ((var abc) (from abcdef)))
  (Export Stdout))
  |}
  in
  try program |> Program.T.of_string |> Interpreter.T.interpret with
  | Failure msg ->
    print_endline msg;
    [%expect {| variable abc already set |}]
;;
