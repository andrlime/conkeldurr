module T : sig
  type t =
    | String of string
    | Integer of int
    | Float of float
    | Boolean of bool

  type v =
    | Constant of t
    | Mutable of t

  val get_type : t -> string
  val get_value : t -> string
  val to_string : Variable.T.t * v -> string
  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end
