(* A generalised Hashtbl.t backed store for various types, like variables and spreadsheets *)
module T : sig
  type 'a t = { data : (string, 'a) Hashtbl.t }

  val create : unit -> 'a t
  val clear : 'a t -> unit
  val set_key : 'a t -> string -> 'a -> unit
  val get_key : 'a t -> string -> 'a
  val to_list : 'a t -> (string * 'a) list
  val to_string : 'a t -> (string * 'a -> string) -> string
end
