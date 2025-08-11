(* A single record in a spreadsheet. For the most part identical to Literal, but by no means the same. *)
module Value : sig
  type record_type =
    | Enum of string
    | String of string
    | Integer of int
    | Float of float
    | Boolean of bool

  val sexp_of_record_type : record_type -> Sexplib0.Sexp.t

  type t =
    { name : string
    ; value : record_type
    }

  val sexp_of_t : t -> Sexplib0.Sexp.t
  val from_header : Header.T.t * string -> t
  val to_json : t -> string
end

(* A spreadsheet row, i.e a list of Record.Value.t *)
module T : sig
  type t = Value.t list

  val sexp_of_t : t -> Sexplib0.Sexp.t
  val from_list : Header.T.t list -> string list -> t
  val to_string : t -> string
  val to_json : t -> string
end
