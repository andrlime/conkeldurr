open Sexplib.Std

module Keywords = struct
  let keywords_list = [ "abstract"
  ; "any"
  ; "as"
  ; "asserts"
  ; "async"
  ; "await"
  ; "boolean"
  ; "break"
  ; "case"
  ; "catch"
  ; "class"
  ; "const"
  ; "continue"
  ; "debugger"
  ; "declare"
  ; "default"
  ; "delete"
  ; "do"
  ; "else"
  ; "enum"
  ; "export"
  ; "extends"
  ; "false"
  ; "finally"
  ; "for"
  ; "from"
  ; "function"
  ; "get"
  ; "if"
  ; "implements"
  ; "import"
  ; "in"
  ; "infer"
  ; "instanceof"
  ; "interface"
  ; "is"
  ; "keyof"
  ; "let"
  ; "module"
  ; "namespace"
  ; "never"
  ; "new"
  ; "null"
  ; "number"
  ; "object"
  ; "of"
  ; "package"
  ; "private"
  ; "protected"
  ; "public"
  ; "readonly"
  ; "require"
  ; "return"
  ; "set"
  ; "static"
  ; "string"
  ; "super"
  ; "switch"
  ; "symbol"
  ; "this"
  ; "throw"
  ; "true"
  ; "try"
  ; "type"
  ; "typeof"
  ; "undefined"
  ; "unique"
  ; "unknown"
  ; "var"
  ; "void"
  ; "while"
  ; "with"
  ; "yield"
  ]
  
  let keywords =
    let tbl = Hashtbl.create 97 in
    List.iter
      (fun kw -> Hashtbl.add tbl kw ())
      keywords_list;
    tbl
  ;;

  let is_keyword name =
    Hashtbl.mem keywords name
  ;;
end

module T = struct
  type t = string [@@deriving sexp]
end
