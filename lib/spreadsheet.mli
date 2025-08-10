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
    
    val header_of_string : string -> t
    val header_to_string : t -> string
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
end

module CsvSpreadsheet : sig
  type packed_column = Pack : 'a Column.t -> packed_column
  type t = packed_column list

  val from_string : string -> t
  val get_json : t -> string
  val get_interface : t -> string
end
