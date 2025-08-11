module Path : sig
  type t = Csv of string

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end

module CsvSpreadsheet : sig
  type t =
    { headers : Header.T.t list
    ; records : Record.T.t list
    }

  val from_string : string -> t
  val from_path : string -> t
  val get_json : t -> string
  val get_interface : t -> string
end
