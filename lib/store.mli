module T : sig
  type 'a t = { data : (string, 'a) Hashtbl.t }

  type result =
    | Success
    | Failure of string

  val create : unit -> 'a t
  val set_key : 'a t -> string -> 'a -> result
  val get_key : 'a t -> string -> result
  val to_list : 'a t -> (string * 'a) list
  val to_string : 'a t -> (string * 'a -> string) -> string
end
