module T = struct
  type t = string * Variable.T.t

  let to_string (var, from) = Printf.sprintf "import { %s } from \"%s\";" var from
end
