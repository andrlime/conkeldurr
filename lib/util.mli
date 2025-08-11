module T : sig
  val is_not_space : char -> bool
  val quote : string -> string
  val unquote : string -> string
  val get_current_date : unit -> string
end
