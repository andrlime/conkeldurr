module Path : sig
  type t = Csv of string

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
end

module Csv0 : sig
  type t =
    { headers : Header.T.t list
    ; records : Record.T.t list
    }

  type u =
    { interface : Variable.T.t
    ; contents : t
    }

  val from_string : string -> t
  val from_path : string -> t
  val get_json : string -> string -> t -> string
  val get_interface : string -> t -> string
end

type t = Csv of Csv0.u

module Writer : sig
  val to_string : string * t -> string
end
