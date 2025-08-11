module T = struct
  let to_string (var, from) = Printf.sprintf "import { %s } from \"%s\";" var from
end
