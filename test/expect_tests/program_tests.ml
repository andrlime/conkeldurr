open Conkeldurr

let%expect_test "interpreter_passes_on_good_program" =
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

let%expect_test "interpreter_fails_on_duplicate_variables" =
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
