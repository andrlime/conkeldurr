open Types

(** [print_row (l : string list)] Prints a tab separated CSV row for debugging *)
let print_row (l : string list) =
  let res = l |> List.iter (Printf.printf "%s\t") in
  print_newline res
;;

let print_csv (s : string list list) : unit = s |> List.iter print_row

let print_column (col : spreadsheet_column_name_t * spreadsheet_column_t) =
  let col_name, col_data = col in
  Printf.printf "column %s\t" col_name;
  match col_data with
  | GenericColumn list ->
    Printf.printf "untyped\n";
    List.iter (Printf.printf "%s\t") list;
    Printf.printf "\n"
  | NumberColumn list ->
    Printf.printf "type number\n";
    List.iter (Printf.printf "%s\t") list;
    Printf.printf "\n"
  | StringColumn list ->
    Printf.printf "type string\n";
    List.iter (Printf.printf "%s\t") list;
    Printf.printf "\n"
  | PathColumn list ->
    Printf.printf "type path\n";
    List.iter (Printf.printf "%s\t") list;
    Printf.printf "\n"
;;

(** [transpose (list : 'a list list)] Transposes a 2D list *)
let rec transpose = function
  | [] | [] :: _ -> []
  | rows -> List.map List.hd rows :: transpose (List.map List.tl rows)
;;

(** [validate_csv_size (loaded_csv : string list list)] Ensure that a CSV does not have zero rows or zero columns *)
let validate_csv_size (loaded_csv : string list list) : string list list =
  let column_count = List.length loaded_csv in
  if column_count == 0
  then raise (Exceptions.invalid_csv_spreadsheet_factory ())
  else (
    let row_count = List.length (List.hd loaded_csv) in
    if row_count == 0
    then raise (Exceptions.invalid_csv_spreadsheet_factory ())
    else loaded_csv)
;;

let read_header (header : string) : spreadsheet_column_type_t * spreadsheet_column_name_t =
  let split_header = String.split_on_char ':' header in
  if List.length split_header > 2
  then raise (Exceptions.invalid_csv_header_factory ())
  else (
    match split_header with
    | [ col_name ] -> "notype", col_name
    | [ col_name; col_type ] -> col_type, col_name
    | [] | _ -> raise (Exceptions.invalid_csv_spreadsheet_factory ()))
;;

(**
[read (path : string)]
Open a CSV spreadsheet by path and convert it to parsed_spreadsheet_t IR
TODO: When columns don't have values in all rows, flag it as optional
*)
let read (path : string) : parsed_spreadsheet_t =
  (* todo: trim tail of file, so extra new lines beyond one *)
  Csv.load path
  |> transpose
  |> validate_csv_size
  |> List.map (fun raw_column ->
    let data_elements = List.tl raw_column in
    match read_header (List.hd raw_column) with
    | "notype", col_name -> col_name, GenericColumn data_elements
    | "number", col_name -> col_name, NumberColumn data_elements
    | "string", col_name -> col_name, StringColumn data_elements
    | "path", col_name -> col_name, PathColumn data_elements
    | _ -> raise (Exceptions.invalid_csv_spreadsheet_factory ()))
;;
