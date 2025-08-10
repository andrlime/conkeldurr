module T : sig
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

module Parser : sig
  val parse : string -> T.t

  (* Returns self if no dupes, else raises Failure *)
  val check_duplicates : T.t list -> T.t list
end
