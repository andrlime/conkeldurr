module Path : sig
  type t = Csv of string

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end

module Header : sig
  type number_type =
    | I of int
    | F of float

  type t =
    | String of string
    | Boolean of string
    | Float of string
    | Integer of string
    | Number of string

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val of_string : string -> t
  val to_string : t -> string
  val get_string : t -> string
end

module Column : sig
  type 'a t =
    { name : string
    ; header : Header.t
    ; data : 'a list
    }
end

module Parser : sig
  val parse_column_header : string -> Header.t

  (* Returns self if no dupes, else raises Failure *)
  val check_duplicates : Header.t list -> Header.t list
end

module CsvSpreadsheet : sig
  type packed_column = Pack : 'a Column.t -> packed_column
  type t = packed_column list

  val header_row : Csv.t -> string list
  val body_rows : Csv.t -> Csv.t
  val from_string : string -> Csv.t
  val from_path : string -> Csv.t
  val from_csv : Csv.t -> t
  val get_json : t -> string
  val get_interface : t -> string
end
