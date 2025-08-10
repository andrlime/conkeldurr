module T : sig
  type t = string

  val from_list : Header.T.t list -> string list -> t
end
