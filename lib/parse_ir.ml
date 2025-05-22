open Types

(** [parse_const (line : scanned_line_list)] Takes a file_line that starts with const and builds the command struct *)
let parse_const (line : scanned_line_list) : timburr_function =
  match line with
  | [ "const"; _constant_value; variable_name ] -> Const (String "", variable_name)
  | _ -> raise (Exceptions.invalid_const_call_factory line)
;;

(** [parse_parse (line : scanned_line_list)] Takes a file_line that starts with parse and builds the command struct *)
let parse_parse (line : scanned_line_list) : timburr_function =
  match line with
  | [ "parse"; file_name; variable_name ] -> ParseUntyped (file_name, variable_name)
  | [ "parse"; file_name; interface_name; variable_name ] ->
    ParseTyped (file_name, interface_name, variable_name)
  | _ -> raise (Exceptions.invalid_parse_command_factory line)
;;

(** [parse_dump (line : scanned_line_list)] Takes a file_line that starts with dump and builds the command struct *)
let parse_dump (line : scanned_line_list) : timburr_function =
  match line with
  | [ "dump"; file_name ] -> Dump file_name
  | _ -> raise (Exceptions.invalid_dump_command_factory line)
;;

(** [parse_env (line : scanned_line_list)] Takes a file_line that starts with env and builds the command struct *)
let parse_env (line : scanned_line_list) : timburr_function =
  match line with
  | [ "env"; src; dest ] -> EnvCopy (src, dest)
  | [ "env"; dest ] -> EnvSet dest
  | _ -> raise (Exceptions.invalid_env_command_factory line)
;;

(** [parse_flush_bucket (line : scanned_line_list)] Takes a file_line that starts with flush_bucket and builds the command struct *)
let parse_flush_bucket (line : scanned_line_list) : timburr_function =
  match line with
  | [ "flush"; s3_bucket_name ] -> FlushBucket s3_bucket_name
  | [ "flush_bucket"; s3_bucket_name ] -> FlushBucket s3_bucket_name
  | _ -> raise (Exceptions.invalid_flush_call_factory line)
;;

(** [parse_pass (_line : scanned_line_list)] Parses a blank line, comment, or a pass line into a pass token *)
let parse_pass (_line : scanned_line_list) : timburr_function = Pass

(** [parse_line_to_ir (line : file_line)] Takes a file line and converts it to a more interpretable interface of command and arguments *)
let parse_line_to_ir ((line_number, line_content) : file_line_t) : timburr_function =
  Printf.printf "Parsing line %d:\t%s\n" line_number line_content;
  line_content
  |> Line_scanner.scan_line
  |> fun tokens ->
  match tokens with
  | [] | "pass" :: _ | "#" :: _ -> parse_pass tokens
  | "const" :: _ -> parse_const tokens
  | "parse" :: _ -> parse_parse tokens
  | "dump" :: _ -> parse_dump tokens
  | "env" :: _ -> parse_env tokens
  | "flush" :: _ -> parse_flush_bucket tokens
  | "flush_bucket" :: _ -> parse_flush_bucket tokens
  | first :: _ ->
    raise (Exceptions.invalid_function_name_exception_factory line_number first)
;;

(** [parse_all_lines_to_ir (lines : file_line list)] Converts all file_line to the program intermediate representation *)
let parse_all_lines_to_ir (lines : file_line_t list) : timburr_function list =
  List.map parse_line_to_ir lines
;;
