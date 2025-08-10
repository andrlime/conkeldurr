module T = struct
  type state =
    { variable_store : Literal.T.v Store.T.t
      (* interface_store : Interface.T.t Store.T.t *)
    }

  let interpret_read_constant state (node : Ast.ReadConstant.t) =
    let variable, value = node.var, node.value in
    if Variable.Keywords.is_keyword variable
    then raise (Failure ("invalid TypeScript variable name " ^ variable));
    let store = state.variable_store in
    let result = Store.T.set_key store variable (Constant value) in
    match result with
    | Store.T.Success -> ()
    | Store.T.Failure msg -> raise (Failure msg)
  ;;

  let interpret_read_variable state (node : Ast.ReadVariable.t) =
    let variable, value = node.var, node.value in
    if Variable.Keywords.is_keyword variable
    then raise (Failure ("invalid TypeScript variable name " ^ variable));
    let store = state.variable_store in
    let result = Store.T.set_key store variable (Mutable value) in
    match result with
    | Store.T.Success -> ()
    | Store.T.Failure msg -> raise (Failure msg)
  ;;

  let interpret_read_spreadsheet _ _ = raise (Failure "Not implemented")

  let export state (node : Ast.Export.t) =
    let contents = Store.T.to_string state.variable_store Literal.T.to_string in
    match node with
    | Ast.Export.File file -> Io.write_file file contents
    | Ast.Export.Stdout -> print_endline contents
  ;;

  let interpret_node state node =
    match node with
    | Ast.Node.ReadConstant n -> interpret_read_constant state n
    | Ast.Node.ReadVariable n -> interpret_read_variable state n
    | Ast.Node.ReadSpreadsheet n -> interpret_read_spreadsheet state n
    | Ast.Node.Export n -> export state n
  ;;

  let create_blank_state () = { variable_store = Store.T.create () }

  let interpret (program : Program.T.t) =
    let state = create_blank_state () in
    List.iter (interpret_node state) program.ast
  ;;
end
