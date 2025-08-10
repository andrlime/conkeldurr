let is_not_space char = char <> ' ' && char <> '\t'
let quote str = "\"" ^ str ^ "\""
let unquote str = String.sub str 1 (String.length str - 2)

let set_working_directory input =
  let full_path = input |> Filename_unix.realpath in
  full_path |> Filename.dirname |> Sys.chdir;
  full_path
;;

let get_absolute_file_path file =
  unquote file |> Filename_unix.realpath
;;
