module T = struct
  let is_not_space char = char <> ' ' && char <> '\t'
  let quote str = "\"" ^ str ^ "\""

  let unquote str =
    let firstchar = String.get str 0 in
    let lastindex = String.length str - 1 in
    let lastchar = String.get str lastindex in
    match firstchar, lastchar with
    | '"', '"' -> String.sub str 1 (lastindex - 1)
    | _, _ -> str
  ;;

  let get_current_date () =
    let today = Unix.localtime (Unix.time ()) in
    let day = today.Unix.tm_mday in
    let month = today.Unix.tm_mon + 1 in
    let year = today.Unix.tm_year + 1900 in
    Printf.sprintf "The current date is %04d-%02d-%02d" year month day
  ;;
end
