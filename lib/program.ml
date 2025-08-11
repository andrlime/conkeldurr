open Sexplib.Std

module T = struct
  type ast = Ast.Node.t list [@@deriving sexp]
  type t = { ast : ast }

  let[@inline] of_string str =
    let new_ast = str |> Sexplib.Sexp.of_string |> ast_of_sexp in
    { ast = new_ast }
  ;;

  let[@inline] to_string program = program.ast |> sexp_of_ast |> Sexplib.Sexp.to_string

  let[@inline] to_readable_string program =
    program.ast |> List.map Ast.Node.to_string |> String.concat "\n"
  ;;
end
