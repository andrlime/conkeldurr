open Types

let flatten_scanned_line_list (line : scanned_line_list) = String.concat " " line

exception InvalidFunctionName of string

let invalid_function_name_exception_factory
      (line_number : line_number_t)
      (func_name : string)
  =
  InvalidFunctionName
    (Printf.sprintf "(line %d) Invalid function name: %s" line_number func_name)
;;

exception InvalidConstCall of string

let invalid_const_call_factory (line : scanned_line_list) =
  InvalidConstCall (flatten_scanned_line_list line)
;;

exception InvalidFlushCall of string

let invalid_flush_call_factory (line : scanned_line_list) =
  InvalidFlushCall (flatten_scanned_line_list line)
;;

exception InvalidParseCommand of string

let invalid_parse_command_factory (line : scanned_line_list) =
  InvalidParseCommand (flatten_scanned_line_list line)
;;

exception InvalidDumpCommand of string

let invalid_dump_command_factory (line : scanned_line_list) =
  InvalidDumpCommand (flatten_scanned_line_list line)
;;

exception InvalidEnvCommand of string

let invalid_env_command_factory (line : scanned_line_list) =
  InvalidEnvCommand (flatten_scanned_line_list line)
;;

exception FileContainsInvalidLines of string

let invalid_file_factory () =
  FileContainsInvalidLines "File contains invalid input, check logs for details."
;;

exception InvalidCsvSpreadsheet of string

let invalid_csv_spreadsheet_factory () =
  InvalidCsvSpreadsheet "Invalid CSV spreadsheet. Make sure data exists!"
;;

exception InvalidCsvHeader of string

let invalid_csv_header_factory () =
  InvalidCsvHeader
    "Invalid CSV header! Make sure to only include one : delimiter per column"
;;

exception ProgramFailedExecution of string

let program_failed_exception_factory () =
  ProgramFailedExecution "Program failed execution!"
;;

exception NotImplementedException of string

let not_implemented_factory () = NotImplementedException "Feature not implemented"
