open Types

(** [read_file_into_lines (file_name : string)] Reads and returns a list of lines of a non-encoded file *)
let read_file_into_lines (file_name : string) : string list =
  In_channel.with_open_text file_name (fun ic -> In_channel.input_lines ic)
;;

(** [parse_single_line (list_index : int) (line_content : string)] Converts a single line into a (line_number, line_content) tuple *)
let parse_single_line (list_index : int) (line_content : string) : file_line_t =
  list_index, line_content
;;

(** [cleanup_lines (file_lines : string list)] Cleans up a list of file lines into an enumerated list of structs *)
let cleanup_lines (file_lines : string list) : file_line_t list =
  file_lines |> List.mapi parse_single_line
;;
