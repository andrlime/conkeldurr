open Types

let write_const_to_ts (variable : variable_name_t * const_value_type_t)
  : typescript_code_t
  =
  let name, value = variable in
  print_newline ();
  let val_type, val_string =
    match value with
    | Number num -> "number", num
    | String str ->
      ( "string"
      , Line_scanner.quote str (* TODO: move those functions into Util (util.ml) *) )
  in
  "const " ^ name ^ ": " ^ val_type ^ " = " ^ val_string ^ ";"
;;

let get_interface_string (_sheet : parsed_spreadsheet_t) : typescript_code_t = "A"
let get_sheet_string (_sheet : parsed_spreadsheet_t) : typescript_code_t = "A"

let write_spreadsheet_to_ts
      (names : (variable_name_t * interface_name_t) * parsed_spreadsheet_t)
  : typescript_code_t
  =
  let (var_name, interface_name), sheet = names in
  "interface "
  ^ interface_name
  ^ " {"
  ^ get_interface_string sheet
  ^ "}"
  ^ ";"
  ^ "\n\n"
  ^ "const "
  ^ var_name
  ^ ": "
  ^ interface_name
  ^ " = "
  ^ get_sheet_string sheet
  ^ ";"
;;

let hsh_to_list (hsh : ('a, 'b) Hashtbl.t) : ('a * 'b) list =
  hsh |> Hashtbl.to_seq |> List.of_seq
;;

let write_global_state_to_ts (state : global_state_t) : typescript_code_t =
  let var_store, spreadsheet_store, _ = state in
  let const_string =
    var_store |> hsh_to_list |> List.map write_const_to_ts |> String.concat "\n\n"
  in
  let spreadsheet_string =
    spreadsheet_store
    |> hsh_to_list
    |> List.map write_spreadsheet_to_ts
    |> String.concat "\n\n"
  in
  const_string ^ "\n\n\n" ^ spreadsheet_string ^ "\n"
;;
