open Sexplib.Std

module T = struct
  type t =
    | String of string
    | Boolean of string
    | Float of string
    | Integer of string
    | Number of string
  [@@deriving sexp]

  let of_string hdr = hdr |> Sexplib.Sexp.of_string |> t_of_sexp
  let to_sexp_string hdr = hdr |> sexp_of_t |> Sexplib.Sexp.to_string

  let to_string hdr =
    match hdr with
    | String s -> s ^ ": string;"
    | Boolean s -> s ^ ": boolean;"
    | Float s -> s ^ ": number;"
    | Integer s -> s ^ ": number;"
    | Number s -> s ^ ": number;"
  ;;

  let get_string hdr =
    match hdr with
    | String s -> s
    | Boolean s -> s
    | Float s -> s
    | Integer s -> s
    | Number s -> s
  ;;
end

module Parser = struct
  let parse hdr = hdr |> T.of_string

  let check_duplicates headers =
    let seen = Hashtbl.create 97 in
    headers
    |> List.iter (fun hdr ->
      let header_name = T.get_string hdr in
      if Hashtbl.mem seen header_name
      then raise (Failure "Cannot have duplicate columns")
      else Hashtbl.add seen header_name ())
  ;;

  let parse_all headers = headers |> List.map parse
end

type t = T.t list [@@deriving sexp]
