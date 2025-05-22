type line_number_t = int
type file_name_t = string
type file_content_t = string
type file_line_t = line_number_t * file_content_t
type env_name_t = string
type interface_name_t = string
type variable_name_t = string
type s3_bucket_name_t = string
type scanned_line_list = string list

type const_value_type_t =
  | Number of int
  | String of string

type timburr_function =
  | Pass
  | Const of const_value_type_t * variable_name_t
  | ParseTyped of file_name_t * interface_name_t * variable_name_t
  | ParseUntyped of file_name_t * variable_name_t
  | Dump of file_name_t
  | EnvCopy of env_name_t * env_name_t
  | EnvSet of env_name_t
  | FlushBucket of s3_bucket_name_t

type spreadsheet_column_t =
  | NumberColumn of int list
  | StringColumn of string list
  | PathColumn of file_name_t list

type parsed_spreadsheet = spreadsheet_column_t list
