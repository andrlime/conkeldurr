open Sexplib.Std

module RecordValue = struct
  type record_type =
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

  let parse_string str = String str

  let parse_boolean str =
    match str with
    | "false" | "False" | "0" | "FALSE" -> Boolean false
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
    | String name -> { name; value = parse_string element }
    | Boolean name -> { name; value = parse_boolean element }
    | Integer name -> { name; value = parse_integer element }
    | Float name | Number name -> { name; value = parse_float element }
  ;;
end

module T = struct
  type t = RecordValue.t list [@@deriving sexp]

  let from_list headers list =
    List.combine headers list |> List.map RecordValue.from_header
  ;;

  let to_string t = t |> sexp_of_t |> Sexplib.Sexp.to_string
end
