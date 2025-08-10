open Sexplib.Std

module T = struct
  type t =
    | String of string
    | Integer of int
    | Float of float
    | Boolean of bool
  [@@deriving sexp]

  type v =
    | Constant of t
    | Mutable of t

  let get_type t =
    match t with
    | String _ -> "string"
    | Integer _ -> "number"
    | Float _ -> "number"
    | Boolean _ -> "boolean"
  ;;

  let value_to_string t =
    match t with
    | String s -> "string", Io.quote s
    | Integer i -> "number", string_of_int i
    | Float f -> "number", string_of_float f
    | Boolean b -> "boolean", if b then "true" else "false"
  ;;

  let const_to_string var t =
    let varname = var in
    let vartype, varvalue = value_to_string t in
    Printf.sprintf "export const %s: %s = %s;" varname vartype varvalue
  ;;

  let mutable_to_string var t =
    let varname = var in
    let vartype, varvalue = value_to_string t in
    Printf.sprintf "export let %s: %s = %s;" varname vartype varvalue
  ;;

  let to_string (var, literal) =
    match literal with
    | Constant v -> const_to_string var v
    | Mutable v -> mutable_to_string var v
  ;;
end
