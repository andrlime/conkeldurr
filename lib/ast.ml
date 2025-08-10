open Sexplib.Std

module ReadConstant = struct
  type t =
    { var : Variable.T.t
    ; value : Literal.T.t
    }
  [@@deriving sexp]

  let to_string node =
    Printf.sprintf
      "ReadConstant to variable %s: %s"
      node.var
      (Literal.T.get_type node.value)
  ;;
end

module ReadVariable = struct
  type t =
    { var : Variable.T.t
    ; value : Literal.T.t
    }
  [@@deriving sexp]

  let to_string node =
    Printf.sprintf
      "ReadVariable to variable %s: %s"
      node.var
      (Literal.T.get_type node.value)
  ;;
end

module ReadSpreadsheet = struct
  type t =
    { var : Variable.T.t
    ; interface : Variable.T.t
    ; path : Spreadsheet.Path.t
    }
  [@@deriving sexp]

  let to_string node =
    let filepath =
      match node.path with
      | Csv f -> "CSV file " ^ f
    in
    Printf.sprintf
      "ReadSpreadsheet from path %s to variable %s, interface %s"
      filepath
      node.var
      node.interface
  ;;
end

module Export = struct
  type t =
    | File of string
    | Stdout
  [@@deriving sexp]

  let to_string node =
    Printf.sprintf
      "Export to %s"
      (match node with
       | File f -> "file " ^ f
       | Stdout -> "stdout")
  ;;
end

module Node = struct
  type t =
    | ReadConstant of ReadConstant.t
    | ReadVariable of ReadVariable.t
    | ReadSpreadsheet of ReadSpreadsheet.t
    | Export of Export.t
  [@@deriving sexp]

  let to_string node =
    match node with
    | ReadConstant n -> ReadConstant.to_string n
    | ReadVariable n -> ReadVariable.to_string n
    | ReadSpreadsheet n -> ReadSpreadsheet.to_string n
    | Export n -> Export.to_string n
  ;;
end
