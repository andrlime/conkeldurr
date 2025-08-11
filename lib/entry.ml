let entry_point file =
  file
  |> Io.set_working_directory
  |> Io.read_file
  |> Program.T.of_string
  |> Interpreter.T.interpret
;;
