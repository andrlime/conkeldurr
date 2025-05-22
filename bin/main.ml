open Cmdliner

let main () = Cmd.eval Cli.main_cmd
let () = if !Sys.interactive then () else exit (main ())
