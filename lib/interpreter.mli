(* Represents a stateful interpreter that stores everything in hash maps *)
module T : sig
  type state =
    { variable_store : Literal.T.v Store.T.t
    ; spreadsheet_store : Spreadsheet.t Store.T.t
    ; interface_set : Variable.T.t Store.T.t
    ; import_store : Variable.T.t Store.T.t
    ; root_directory : string
    }

  val interpret_node : state -> Ast.Node.t -> unit
  val create_blank_state : unit -> state

  (* Entry point to the module, and interprets nodes using List.iter *)
  val interpret : Program.T.t -> unit
end
