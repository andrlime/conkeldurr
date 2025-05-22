let print_each_character (message : string) : unit =
  List.init (String.length message) (String.get message)
  |> List.iter (fun c -> print_endline (String.make 1 c))
;;
