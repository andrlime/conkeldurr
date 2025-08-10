module ProgramCounter : sig
  type t = { line : int }

  val new_pc : unit -> t
end

module T : sig
  type ast = Ast.Node.t list

  val ast_of_sexp : Sexplib0.Sexp.t -> ast
  val sexp_of_ast : ast -> Sexplib0.Sexp.t

  type t =
    { ast : ast
    ; pc : ProgramCounter.t
    }

  val of_string : string -> t
  val to_string : t -> string
end
