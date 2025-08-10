open Sexplib.Std

module Path = struct
  type t = Csv of string [@@deriving sexp]
end

(* module T = struct

end *)
