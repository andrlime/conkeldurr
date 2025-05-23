open Types

(** [print_row (l : string list)] Prints a tab separated CSV row for debugging *)
let print_row (l : string list) =
  let res = l |> List.iter (Printf.printf "%s\t") in
  print_newline res
;;

(** [transpose (list : 'a list list)] Transposes a 2D list *)
let rec transpose = function
  | [] | [] :: _ -> []
  | rows -> List.map List.hd rows :: transpose (List.map List.tl rows)
;;

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

let read (path : string) : parsed_spreadsheet_t =
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
