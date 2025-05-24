type line_number_t = int
type file_name_t = string
type file_content_t = string
type file_line_t = line_number_t * file_content_t
type env_name_t = string
type interface_name_t = string
type variable_name_t = string
type s3_bucket_name_t = string
type scanned_line_list = string list
type spreadsheet_column_name_t = string
type spreadsheet_column_type_t = string

type const_value_type_t =
  | Number of string
  | String of string

type timburr_function =
  | Pass
  | Const of const_value_type_t * variable_name_t
  | ParseTyped of file_name_t * interface_name_t * variable_name_t
  | ParseUntyped of file_name_t * variable_name_t
  | Env of env_name_t * env_name_t
  | FlushBucket of s3_bucket_name_t

type spreadsheet_column_t =
  | GenericColumn of string list
  | NumberColumn of string list
  | StringColumn of string list
  | PathColumn of file_name_t list

type parsed_spreadsheet_t = (spreadsheet_column_name_t * spreadsheet_column_t) list

(* State types *)
type variable_store = (variable_name_t, const_value_type_t) Hashtbl.t

type spreadsheet_store =
  (variable_name_t * interface_name_t, parsed_spreadsheet_t) Hashtbl.t

type env_store = (env_name_t, string) Hashtbl.t
type global_state_t = variable_store * spreadsheet_store * env_store

(* todo: encode order that things should be exported in, i.e. a queue *)
