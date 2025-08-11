(* Represents a program linked list of AST nodes. Type t can be extended with a program counter, but it doesn't really serve a purpose other than being a wrapper. *)
module T : sig
  type ast = Ast.Node.t list

  val ast_of_sexp : Sexplib0.Sexp.t -> ast
  val sexp_of_ast : ast -> Sexplib0.Sexp.t

  type t = { ast : ast }

  val of_string : string -> t
  val to_string : t -> string
  val to_readable_string : t -> string
end
