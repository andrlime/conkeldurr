module T = struct
  type state =
    { variable_store : Literal.T.v Store.T.t
    ; spreadsheet_store : Spreadsheet.t Store.T.t
    ; interface_set : Variable.T.t Store.T.t
    }

  let interpret_read_constant state (node : Ast.ReadConstant.t) =
    let variable, value = node.var, node.value in
    if not (Variable.T.is_valid variable)
    then failwith ("invalid TypeScript variable name " ^ variable);
    let store = state.variable_store in
    Store.T.set_key store variable (Constant value)
  ;;

  let interpret_read_variable state (node : Ast.ReadVariable.t) =
    let variable, value = node.var, node.value in
    if not (Variable.T.is_valid variable)
    then failwith ("invalid TypeScript variable name " ^ variable);
    let store = state.variable_store in
    Store.T.set_key store variable (Mutable value)
  ;;

  let interpret_csv_spreadsheet state var interface path =
    if not (Io.Files.is_valid_path path) then raise (Failure ("invalid path " ^ path));
    let sheet_store = state.spreadsheet_store in
    let new_sheet = Spreadsheet.Csv0.from_path path in
    Store.T.set_key sheet_store var (Spreadsheet.Csv { interface; contents = new_sheet });
    Store.T.set_key state.interface_set interface interface
  ;;

  let interpret_read_spreadsheet state (node : Ast.ReadSpreadsheet.t) =
    let variable, interface, path = node.var, node.interface, node.path in
    if not (Variable.T.is_valid variable)
    then failwith ("invalid TypeScript variable name " ^ variable);
    if not (Variable.T.is_valid interface)
    then failwith ("invalid TypeScript interface name " ^ interface);
    match path with
    | Csv p -> interpret_csv_spreadsheet state variable interface p
  ;;

  let interpret_export state (node : Ast.Export.t) =
    let var_contents = Store.T.to_string state.variable_store Literal.T.to_string in
    let spreadsheet_contents =
      Store.T.to_string state.spreadsheet_store Spreadsheet.Writer.to_string
    in
    let contents =
      Printf.sprintf
        {|
%s
%s
      |}
        var_contents
        spreadsheet_contents
    in
    match node with
    | Ast.Export.File file -> Io.write_file file contents
    | Ast.Export.Stdout -> print_endline contents
  ;;

  let reset_state state =
    Store.T.clear state.variable_store;
    Store.T.clear state.spreadsheet_store;
    Store.T.clear state.interface_set
  ;;

  let interpret_node state node =
    match node with
    | Ast.Node.ReadConstant n -> interpret_read_constant state n
    | Ast.Node.ReadVariable n -> interpret_read_variable state n
    | Ast.Node.ReadSpreadsheet n -> interpret_read_spreadsheet state n
    | Ast.Node.Export n ->
      interpret_export state n;
      reset_state state
  ;;

  let create_blank_state () =
    { variable_store = Store.T.create ()
    ; spreadsheet_store = Store.T.create ()
    ; interface_set = Store.T.create ()
    }
  ;;

  let[@inline] interpret (program : Program.T.t) =
    let state = create_blank_state () in
    List.iter (interpret_node state) program.ast
  ;;
end
