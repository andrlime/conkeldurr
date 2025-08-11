open Conkeldurr
open Cmdliner

let conkeldurr_process_file file =
  file
  |> Io.set_working_directory
  |> Io.read_file
  |> Program.T.of_string
  |> Interpreter.T.interpret;
  let _ =
    Spreadsheet.CsvSpreadsheet.from_string
      "(String name),(Integer field),(Number otherfield)\nd,e,f"
  in
  ()
;;

let input_file_arg =
  let doc = "A file to interpret, provided via --input or -i." in
  Arg.(required & opt (some file) None & info [ "i"; "input" ] ~docv:"PATH" ~doc)
;;

let main_cmd =
  let term = Term.(const conkeldurr_process_file $ input_file_arg) in
  Cmd.v (Cmd.info "conkeldurr" ~version:"%%VERSION%%") term
;;

let main () = Cmd.eval main_cmd
let () = if !Sys.interactive then () else exit (main ())
