module T : sig
  type ast = Ast.Node.t list

  val ast_of_sexp : Sexplib0.Sexp.t -> ast
  val sexp_of_ast : ast -> Sexplib0.Sexp.t

  type t = { ast : ast }

  val of_string : string -> t
  val to_string : t -> string
  val to_readable_string : t -> string
end
