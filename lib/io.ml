let is_not_space char = char <> ' ' && char <> '\t'
let quote str = "\"" ^ str ^ "\""

let unquote str =
  let firstchar = String.get str 0 in
  let lastindex = String.length str - 1 in
  let lastchar = String.get str lastindex in
  match firstchar, lastchar with
  | '"', '"' -> String.sub str 1 (lastindex - 1)
  | _, _ -> str
;;

let get_absolute_file_path file = file |> unquote |> Filename_unix.realpath

let set_working_directory input =
  let full_path = input |> get_absolute_file_path in
  full_path |> Filename.dirname |> Sys.chdir;
  full_path
;;

let read_file path =
  let channel = open_in path in
  let len = in_channel_length channel in
  let content = really_input_string channel len in
  close_in channel;
  content
;;

let write_file path content =
  let channel = open_out path in
  output_string channel content;
  close_out channel
;;
