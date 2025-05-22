open Types

let is_not_space (character : char) : bool = character <> ' ' && character <> '\t'
let quote (str : string) : string = "\"" ^ str ^ "\""

let scan_line (line_content : file_content_t) : scanned_line_list =
  let length = String.length line_content in
  let rec scan (index : int) (tokens : scanned_line_list) =
    if index >= length
    then List.rev tokens
    else (
      match line_content.[index] with
      | '#' -> List.rev tokens
      | ' ' | '\t' -> scan (index + 1) tokens
      | '\"' | '\'' ->
        let starting_quote = line_content.[index] in
        let starting_ref = ref (index + 1) in
        while !starting_ref < length && line_content.[!starting_ref] <> starting_quote do
          incr starting_ref
        done;
        let token =
          quote @@ String.sub line_content (index + 1) (!starting_ref - index - 1)
        in
        scan (!starting_ref + 1) (token :: tokens)
      | _ ->
        let starting_ref = ref index in
        while !starting_ref < length && is_not_space line_content.[!starting_ref] do
          incr starting_ref
        done;
        let token = String.sub line_content index (!starting_ref - index) in
        scan (!starting_ref + 1) (token :: tokens))
  in
  scan 0 []
;;
