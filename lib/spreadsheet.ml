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
end

module CsvSpreadsheet = struct
  type packed_column = Pack : 'a Column.t -> packed_column
  type t = packed_column list

  let from_string _ = []
  let get_json _ = ""
  let get_interface _ = ""
end
