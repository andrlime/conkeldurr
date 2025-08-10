open Sexplib.Std

module Path = struct
  type t = Csv of string [@@deriving sexp]
end

(* TODO: Extend this to a functor for other input formats *)
module CsvSpreadsheet = struct
  type t =
    { headers : Header.T.t list
    ; records : Record.T.t list
    }

  let header_row csv = List.hd csv
  let body_rows csv = List.tl csv
  let from_string str = Csv.of_string str |> Csv.input_all
  let from_path path = Csv.load path

  let from_csv csv =
    let headers =
      csv |> header_row |> List.map Header.Parser.parse |> Header.Parser.check_duplicates
    in
    let records = csv |> body_rows |> List.map (Record.T.from_list headers) in
    { headers; records }
  ;;

  let get_json _ = ""
  let get_interface _ = ""
end
