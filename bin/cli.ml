open Cmdliner
open Timburr

let hello_world (msg : string) (msg2 : string) =
  Example.print_each_character msg;
  Example.print_each_character msg2
;;

let input_file_arg =
  let doc = "A file to interpret, provided via --input or -i." in
  Arg.(required & opt (some file) None & info [ "i"; "input" ] ~docv:"PATH" ~doc)
;;

let output_file_arg =
  let doc = "Relative filename to write to, provided via --output or -o." in
  Arg.(required & opt (some string) None & info [ "o"; "output" ] ~docv:"PATH" ~doc)
;;

let main_cmd =
  let term = Term.(const hello_world $ input_file_arg $ output_file_arg) in
  Cmd.v (Cmd.info "timburr" ~version:"%%VERSION%%") term
;;
