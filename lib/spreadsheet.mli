module Path : sig
  type t = Csv of string

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end

(* module T = struct
  
end *)
