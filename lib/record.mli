module Value : sig
  type record_type =
    | String of string
    | Integer of int
    | Float of float
    | Boolean of bool

  val sexp_of_record_type : record_type -> Sexplib0.Sexp.t

  type t =
    { name : string
    ; value : record_type
    }

  val sexp_of_t : t -> Sexplib0.Sexp.t
  val from_header : Header.T.t * string -> t
  val to_json : t -> string
end

module T : sig
  type t = Value.t list

  val sexp_of_t : t -> Sexplib0.Sexp.t
  val from_list : Header.T.t list -> string list -> t
  val to_string : t -> string
  val to_json : t -> string
end
