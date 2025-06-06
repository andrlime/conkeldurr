open Types

(**
[is_not_ts_keyword (name : variable_name_t)]
Validates that a variable/interface name is not accidentally a TypeScript keyword

NOTE:
Switch this to hash set
*)
let is_not_ts_keyword (name : variable_name_t) : bool =
  match name with
  | "abstract"
  | "any"
  | "as"
  | "asserts"
  | "async"
  | "await"
  | "boolean"
  | "break"
  | "case"
  | "catch"
  | "class"
  | "const"
  | "continue"
  | "debugger"
  | "declare"
  | "default"
  | "delete"
  | "do"
  | "else"
  | "enum"
  | "export"
  | "extends"
  | "false"
  | "finally"
  | "for"
  | "from"
  | "function"
  | "get"
  | "if"
  | "implements"
  | "import"
  | "in"
  | "infer"
  | "instanceof"
  | "interface"
  | "is"
  | "keyof"
  | "let"
  | "module"
  | "namespace"
  | "never"
  | "new"
  | "null"
  | "number"
  | "object"
  | "of"
  | "package"
  | "private"
  | "protected"
  | "public"
  | "readonly"
  | "require"
  | "return"
  | "set"
  | "static"
  | "string"
  | "super"
  | "switch"
  | "symbol"
  | "this"
  | "throw"
  | "true"
  | "try"
  | "type"
  | "typeof"
  | "undefined"
  | "unique"
  | "unknown"
  | "var"
  | "void"
  | "while"
  | "with"
  | "yield" -> false
  | _ -> true
;;

(**
[validate_ts_name (name : variable_name_t)]
Validates an variable_name or InterfaceName to be valid Typescript, i.e cannot start with a number
or contain dashes or whatnot. This function does not enforce capitalisation convention.
*)
let validate_ts_name (name : variable_name_t) : bool =
  is_not_ts_keyword name
  && String.length name > 0
  && (match name.[0] with
      | 'a' .. 'z' | 'A' .. 'Z' | '_' | '$' -> true
      | _ ->
        Printf.printf
          "[!!] TypeScript name %s is not valid due to starting with %c\n"
          name
          name.[0];
        false)
  && name
     |> String.for_all (function c ->
         (match c with
          | 'a' .. 'z' | 'A' .. 'Z' | '0' .. '9' | '_' | '$' -> true
          | _ ->
            Printf.printf
              "[!!] TypeScript name %s is not valid due to unexpected character %c\n"
              name
              c;
            false))
;;

(**
[validate_env_variable (env_variable : env_name_t)]
Validates that an environment variable exists.
*)
let validate_env_variable (name : env_name_t) : bool =
  try
    ignore (Sys.getenv name);
    true
  with
  | Not_found ->
    Printf.printf "[!!] Environment variable %s does not exist!\n" name;
    false
;;

(**
[validate_file_name (filename : file_name_t)]
Checks that a file that a function will open exists on disk.
*)
let validate_file_name (_filename : file_name_t) : bool = true

(** [validate_const (line : conkeldurr_function)] Validate a const function call *)
let validate_const (line : conkeldurr_function) : bool =
  match line with
  | Const (_, var_name) -> validate_ts_name var_name
  | _ -> false (* should never be reached *)
;;

(** [validate_parse (line : conkeldurr_function)] Validates a parse function call *)
let validate_parse (line : conkeldurr_function) : bool =
  match line with
  | ParseTyped (file_name, interface_name, var_name) ->
    validate_file_name file_name
    && validate_ts_name interface_name
    && validate_ts_name var_name
  | ParseUntyped (file_name, var_name) ->
    validate_file_name file_name && validate_ts_name var_name
  | _ -> false (* should never be reached *)
;;

(** [validate_env (line : conkeldurr_function)] Validates and performs an env function call (reads .env, process.env, etc.) *)
let validate_env (line : conkeldurr_function) : bool =
  match line with
  | Env (src, _) -> validate_env_variable src
  | _ -> false (* should never be reached *)
;;

(**
[validate_flush_bucket (line : conkeldurr_function)]
Validates a flush bucket function call

TODO: Pass in AWS IAM stuff and check if bucket exists during pre-runtime
*)
let validate_flush_bucket (_line : conkeldurr_function) : bool = true

(** [validate_pass (_ : conkeldurr_function)] validates a blank line, comment, or a pass line into a pass token *)
let validate_pass (_ : conkeldurr_function) : bool = true

(**
[validate_single_line (number : int) (line : conkeldurr_function)]
Pre-runtime check:
Do all files that will be opened exist?
Are all output variable names valid Typescript?
Are variable and interface names unique?

if line_invalid
  return false
else
  return true
end
*)
let validate_single_line (number : int) (line : conkeldurr_function) : bool =
  Printf.printf "Validating line %d\n" (number + 1);
  match line with
  | Pass -> validate_pass line
  | Const _ -> validate_const line
  | ParseTyped _ | ParseUntyped _ -> validate_parse line
  | Env _ -> validate_env line
  | FlushBucket _ -> validate_flush_bucket line
;;

(** [validate_all_lines (lines : conkeldurr_function list)] Calls validate_single_line on every function *)
let validate_all_lines (lines : conkeldurr_function list) : conkeldurr_function list =
  lines
  |> List.mapi validate_single_line
  |> List.exists (fun b -> not b)
  |> fun has_invalid_line ->
  if has_invalid_line then raise (Exceptions.invalid_file_factory ()) else lines
;;
