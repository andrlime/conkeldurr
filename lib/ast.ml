open Sexplib.Std

module ReadConstant = struct
  type t =
    { var : Variable.T.t
    ; value : Literal.T.t
    }
  [@@deriving sexp]

  let create_t varname strvalue = { var = varname; value = Literal.T.String strvalue }
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
    ; path : string
    }
  [@@deriving sexp]
end

module Export = struct
  type t = { file : string } [@@deriving sexp]
end

module Node = struct
  type t =
    | ReadConstant of ReadConstant.t
    | ReadVariable of ReadVariable.t
    | ReadSpreadsheet of ReadSpreadsheet.t
    | Export of Export.t
  [@@deriving sexp]
end
