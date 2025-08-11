open Sexplib.Std

module Path = struct
  type t = Csv of string [@@deriving sexp]
end

(* TODO: Extend this to a functor for other input formats *)
module Csv0 = struct
  type t =
    { headers : Header.T.t list
    ; records : Record.T.t list
    }

  type u =
    { interface : Variable.T.t
    ; contents : t
    }

  let header_row csv = List.hd csv
  let body_rows csv = List.tl csv

  let from_csv csv =
    let headers = csv |> header_row |> Header.Parser.parse_all in
    headers |> Header.Parser.check_duplicates;
    let records = csv |> body_rows |> List.map (Record.T.from_list headers) in
    { headers; records }
  ;;

  let from_string str =
    Csv.of_string str
    |> Csv.input_all
    |> List.filter (fun line -> String.length (String.concat "" line) > 0)
    |> from_csv
  ;;

  let from_path path = Csv.load path |> from_csv

  let get_json name interface t =
    t.records
    |> List.map Record.T.to_json
    |> String.concat ",\n"
    |> Printf.sprintf
         {|
export const %s: Array<%s> = [
%s
];
    |}
         name
         interface
  ;;

  let get_interface interface t =
    t.headers
    |> List.map (fun hdr -> "\t" ^ Header.T.to_string hdr)
    |> String.concat "\n"
    |> Printf.sprintf
         {|
export interface %s {
%s
};
    |}
         interface
  ;;
end

type t = Csv of Csv0.u

module Writer = struct
  let csv_to_string name (s : Csv0.u) =
    Printf.sprintf
      "%s %s"
      (Csv0.get_interface s.interface s.contents)
      (Csv0.get_json name s.interface s.contents)
  ;;

  let to_string (name, sheet) =
    match sheet with
    | Csv s -> csv_to_string name s
  ;;
end
