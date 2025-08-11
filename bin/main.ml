open Conkeldurr
open Cmdliner

let conkeldurr_process_file file =
  file |> Entry.entry_point
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
