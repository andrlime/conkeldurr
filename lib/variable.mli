(* Checks if a variable name is a reserved keyword *)
module Keywords : sig
  val keywords_list : string list
  val is_keyword : string -> bool
end

(*
   Checks if a variable name is a valid variable name 
Also checks if an enum name is valid, which could look like Enum.Type
*)
module ValidName : sig
  val check : string -> bool
  val check_enum : string -> bool
end

(* Wraps variables, which are just strings, as sexps and around some useful helpers *)
module T : sig
  type t = string [@@deriving sexp]

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val is_valid : t -> bool
  val is_valid_enum : t -> bool
end
