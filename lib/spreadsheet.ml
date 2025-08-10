open Sexplib.Std

module Path = struct
  type t = Csv of string [@@deriving sexp]
end

module Header = struct
  type number_type =
    | I of int
    | F of float

  type t =
    | String of string
    | Boolean of string
    | Float of string
    | Integer of string
    | Number of string
  [@@deriving sexp]

  let header_of_string hdr = hdr |> Sexplib.Sexp.of_string |> t_of_sexp

  let header_to_string hdr =
    match hdr with
    | String s -> "String " ^ s
    | Boolean s -> "Boolean " ^ s
    | Float s -> "Float " ^ s
    | Integer s -> "Integer " ^ s
    | Number s -> "Number " ^ s
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

module Column = struct
  type 'a t =
    { name : string
    ; header : Header.t
    ; data : 'a list
    }
end

module Parser = struct
  let parse_column_header hdr = hdr |> Header.header_of_string

  let check_duplicates headers =
    let seen = Hashtbl.create 97 in
    headers
    |> List.iter (fun hdr ->
      if Hashtbl.mem seen (Header.get_string hdr)
      then raise (Failure "Cannot have duplicate columns")
      else Hashtbl.add seen (Header.get_string hdr) ());
    headers
  ;;
end

(* TODO: Extend this to a functor for other input formats *)
module CsvSpreadsheet = struct
  type packed_column = Pack : 'a Column.t -> packed_column
  type t = packed_column list

  let header_row csv = List.hd csv
  let body_rows csv = List.tl csv
  let from_string str = Csv.of_string str |> Csv.input_all
  let from_path path = Csv.load path

  let from_csv csv =
    let header =
      csv |> header_row |> List.map Parser.parse_column_header |> Parser.check_duplicates
    in
    (* let body = csv |> body_rows in *)
    header |> List.iter (fun hdr -> print_endline (Header.header_to_string hdr));
    []
  ;;

  let get_json _ = ""
  let get_interface _ = ""
end
