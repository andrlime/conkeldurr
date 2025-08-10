module ReadConstant : sig
  type t =
    { var : string
    ; value : Literal.T.t
    }

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val to_string : t -> string
end

module ReadVariable : sig
  type t =
    { var : string
    ; value : Literal.T.t
    }

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val to_string : t -> string
end

module ReadSpreadsheet : sig
  type t =
    { var : string
    ; interface : string
    ; path : Spreadsheet.Path.t
    }

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val to_string : t -> string
end

module Export : sig
  type t =
    | File of string
    | Stdout

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val to_string : t -> string
end

module Node : sig
  type t =
    | ReadConstant of ReadConstant.t
    | ReadVariable of ReadVariable.t
    | ReadSpreadsheet of ReadSpreadsheet.t
    | Export of Export.t

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val to_string : t -> string
end
