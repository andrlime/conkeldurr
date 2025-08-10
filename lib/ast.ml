open Sexplib.Std

module ReadConstant = struct
  type t =
    { var : Variable.T.t
    ; value : Literal.T.t
    }
  [@@deriving sexp]
end

module ReadVariable = struct
  type t =
    { var : Variable.T.t
    ; value : Literal.T.t
    }
  [@@deriving sexp]
end

module ReadSpreadsheet = struct
  type t =
    { var : Variable.T.t
    ; interface : Variable.T.t
    ; path : Spreadsheet.Path.t
    }
  [@@deriving sexp]
end

module Export = struct
  type t =
    | File of string
    | Stdout
  [@@deriving sexp]
end

module Node = struct
  type t =
    | ReadConstant of ReadConstant.t
    | ReadVariable of ReadVariable.t
    | ReadSpreadsheet of ReadSpreadsheet.t
    | Export of Export.t
  [@@deriving sexp]
end
