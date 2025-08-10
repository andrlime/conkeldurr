open Sexplib.Std

module T = struct
  type t = string [@@deriving sexp]
end
