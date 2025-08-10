open Sexplib.Std

module ProgramCounter = struct
  type t = { line : int }

  let new_pc () = { line = 1 }
end

module T = struct
  type ast = Ast.Node.t list [@@deriving sexp]

  type t =
    { ast : ast
    ; pc : ProgramCounter.t
    }

  let of_string str =
    let new_ast = str |> Sexplib.Sexp.of_string |> ast_of_sexp in
    { ast = new_ast; pc = ProgramCounter.new_pc () }
  ;;

  let to_string program = program.ast |> sexp_of_ast |> Sexplib.Sexp.to_string
end
