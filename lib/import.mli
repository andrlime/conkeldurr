(* Represents a module imported from some file *)
module T : sig
  type t = string * Variable.T.t
  val to_string : t -> string
end
