(* Represents a literal value in const/let statements *)
module T : sig
  (* The actual value. Enum contains the actual enum type, while everything else only contains value. *)
  type t =
    | Enum of string * string
    | String of string
    | Integer of int
    | Float of float
    | Boolean of bool

  (* Represents whether is const or let *)
  type v =
    | Constant of t
    | Mutable of t

  val get_type : t -> string
  val get_value : t -> string
  val to_string : Variable.T.t * v -> string
  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end
