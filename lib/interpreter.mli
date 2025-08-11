module T : sig
  type state =
    { variable_store : Literal.T.v Store.T.t
    ; spreadsheet_store : Spreadsheet.t Store.T.t
    }

  val interpret_node : state -> Ast.Node.t -> unit
  val create_blank_state : unit -> state
  val interpret : Program.T.t -> unit
end
