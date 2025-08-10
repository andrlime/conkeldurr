module T : sig
  type state = { variable_store : Literal.T.v Store.T.t }

  val interpret_read_constant : state -> Ast.ReadConstant.t -> unit
  val interpret_read_variable : state -> Ast.ReadVariable.t -> unit
  val interpret_read_spreadsheet : state -> Ast.ReadSpreadsheet.t -> unit
  val export : state -> Ast.Export.t -> unit
  val interpret_node : state -> Ast.Node.t -> unit
  val create_blank_state : unit -> state
  val interpret : Program.T.t -> unit
end
