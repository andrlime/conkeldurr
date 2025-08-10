open Cmdliner
open Conkeldurr

let conkeldurr_process_file (input_file_name : string) =
  print_endline "-----start------";
  let _ =
    input_file_name
    |> Io.set_working_directory
    |> Io.read_file
    |> Program.T.of_string
    |> Interpreter.T.interpret
    (* |> Program.T.to_string *)
    (* |> print_endline *)
  in
  print_endline "-----end------"
;;

let input_file_arg =
  let doc = "A file to interpret, provided via --input or -i." in
  Arg.(required & opt (some file) None & info [ "i"; "input" ] ~docv:"PATH" ~doc)
;;

let main_cmd =
  let term = Term.(const conkeldurr_process_file $ input_file_arg) in
  Cmd.v (Cmd.info "conkeldurr" ~version:"%%VERSION%%") term
;;
