(* ReadConstant reads a const value, like `export const banana: Fruit = Fruit.Banana` *)
module ReadConstant : sig
  type t =
    { var : string
    ; value : Literal.T.t
    }

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val to_string : t -> string
end

(* ReadVariable reads a mutable value, like `export let apple: Fruit = Fruit.Apple` *)
module ReadVariable : sig
  type t =
    { var : string
    ; value : Literal.T.t
    }

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val to_string : t -> string
end

(* ReadSpreadsheet reads an interface and rows from a spreadsheet at a given path *)
module ReadSpreadsheet : sig
  type t =
    { var : string
    ; interface : string
    ; path : Spreadsheet.Path.t
    }

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val to_string : t -> string
end

(* Import imports modules from external ts files, but does not do any type checking *)
module Import : sig
  type t =
    { var : Variable.T.t
    ; from : Variable.T.t
    }

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val to_string : t -> string
end

(* Export exports everything to either stdout or some file, or some other source *)
module Export : sig
  type t =
    | File of string
    | Stdout

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val to_string : t -> string
end

module Chdir : sig
  type t = string [@@deriving sexp]

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val to_string : t -> string
end

(* Node is a node in the AST tree *)
module Node : sig
  type t =
    | ReadConstant of ReadConstant.t
    | ReadVariable of ReadVariable.t
    | ReadSpreadsheet of ReadSpreadsheet.t
    | Import of Import.t
    | Export of Export.t
    | Chdir of Chdir.t

  val t_of_sexp : Sexplib0.Sexp.t -> t
  val sexp_of_t : t -> Sexplib0.Sexp.t
  val to_string : t -> string
end
