module RecordValue : sig
  type record_type =
    | String of string
    | Integer of int
    | Float of float
    | Boolean of bool
  
  val record_type_of_sexp : Sexplib0.Sexp.t -> record_type
  val sexp_of_record_type : record_type -> Sexplib0.Sexp.t

  type t =
    { name : string
    ; value : record_type
    }
  
  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t

  val parse_string : string -> record_type
  val parse_boolean : string -> record_type
  val parse_float : string -> record_type
  val parse_integer : string -> record_type
  val from_header : Header.T.t * string -> t
end

module T : sig
  type t = RecordValue.t list

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t

  val from_list : Header.T.t list -> string list -> t
end
