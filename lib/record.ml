open Sexplib.Std

module Value = struct
  type record_type =
    | Enum of string
    | String of string
    | Integer of int
    | Float of float
    | Boolean of bool
  [@@deriving sexp]

  type t =
    { name : string
    ; value : record_type
    }
  [@@deriving sexp]

  let parse_enum str =
    if not (Variable.T.is_valid_enum str) then failwith ("invalid enum name " ^ str);
    Enum str
  ;;

  let parse_string str = String str

  let parse_boolean str =
    match String.lowercase_ascii str with
    | "false" | "0" -> Boolean false
    | _ -> Boolean true
  ;;

  let parse_float str =
    try Float (float_of_string str) with
    | Failure _ ->
      let err_msg = Printf.sprintf "Cannot parse %s to float" str in
      raise (Invalid_argument err_msg)
  ;;

  let parse_integer str =
    try Integer (int_of_string str) with
    | Failure _ ->
      let err_msg = Printf.sprintf "Cannot parse %s to int" str in
      raise (Invalid_argument err_msg)
  ;;

  let from_header (header, element) =
    match (header : Header.T.t) with
    | Enum (_, name) -> { name; value = parse_enum element }
    | String name -> { name; value = parse_string element }
    | Boolean name -> { name; value = parse_boolean element }
    | Integer name -> { name; value = parse_integer element }
    | Float name | Number name -> { name; value = parse_float element }
  ;;

  let get_value t =
    match t with
    | Enum e -> e
    | String s -> Util.T.quote s
    | Integer i -> string_of_int i
    | Float f -> string_of_float f
    | Boolean b -> string_of_bool b
  ;;

  let[@inline] to_json t = Printf.sprintf "%s: %s" t.name (get_value t.value)
end

module T = struct
  type t = Value.t list [@@deriving sexp]

  let[@inline] from_list headers list =
    List.combine headers list |> List.map Value.from_header
  ;;

  let[@inline] to_string t = t |> sexp_of_t |> Sexplib.Sexp.to_string

  let[@inline] to_json t =
    t |> List.map Value.to_json |> String.concat ", " |> Printf.sprintf "\t{ %s }"
  ;;
end
