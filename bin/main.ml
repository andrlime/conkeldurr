open Cmdliner

let main () = Cmd.eval Commands.main_cmd
let () = if !Sys.interactive then () else exit (main ())
