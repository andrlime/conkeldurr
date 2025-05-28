open Cmdliner
open Conkeldurr

let conkeldurr_process_file (input_file_name : string) (_output_file_name : string) =
  print_endline "-----start------";
  let _ =
    input_file_name
    |> Read_files.set_working_directory
    |> Read_files.read_file_into_lines
    |> Read_files.cleanup_lines
    |> Parse_ir.parse_all_lines_to_ir
    |> Validate_ir.validate_all_lines
    |> Interpret_ir.run
    (* |> Type_check.lint (* todo: check every column in spreadsheets, add optionals *)
    |> Emit_ts.generate
    |> Tsc.check_compiles
    |> Emit_ts.write *)
    |> Debug.print_state
  in
  print_endline "-----end------"
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
  let term = Term.(const conkeldurr_process_file $ input_file_arg $ output_file_arg) in
  Cmd.v (Cmd.info "conkeldurr" ~version:"%%VERSION%%") term
;;
