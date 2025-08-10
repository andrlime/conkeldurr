module Keywords : sig
  val keywords_list : string list
  val is_keyword : string -> bool
end

module T : sig
  type t = string [@@deriving sexp]

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end
