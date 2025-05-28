open Types

let execute_pass (current_state : global_state_t) (_ : conkeldurr_function)
  : bool * global_state_t
  =
  true, current_state
;;

let execute_const (current_state : global_state_t) (func : conkeldurr_function)
  : bool * global_state_t
  =
  match func with
  | Const (value, name) ->
    let vars, spreadsheets, envs = current_state in
    Hashtbl.add vars name value;
    true, (vars, spreadsheets, envs)
  | _ -> false, current_state
;;

let execute_parse (current_state : global_state_t) (func : conkeldurr_function)
  : bool * global_state_t
  =
  match func with
  | ParseTyped (file, interface, var) ->
    let vars, spreadsheets, envs = current_state in
    let read_csv = Read_csv_spreadsheet.read (Read_files.parse_file_name file) in
    Hashtbl.add spreadsheets (var, interface) read_csv;
    true, (vars, spreadsheets, envs)
  | ParseUntyped (file, var) ->
    let vars, spreadsheets, envs = current_state in
    let read_csv = Read_csv_spreadsheet.read (Read_files.parse_file_name file) in
    Hashtbl.add spreadsheets (var, "") read_csv;
    true, (vars, spreadsheets, envs)
  | _ -> false, current_state
;;

let execute_env (current_state : global_state_t) (func : conkeldurr_function)
  : bool * global_state_t
  =
  match func with
  | Env (src, dest) ->
    let vars, spreadsheets, envs = current_state in
    Hashtbl.add envs dest (Sys.getenv src);
    true, (vars, spreadsheets, envs)
  | _ -> false, current_state
;;

(* todo: env, flush *)

let execute_function (current_state : global_state_t) (func : conkeldurr_function)
  : bool * global_state_t
  =
  match func with
  | Pass -> execute_pass current_state func
  | Const _ -> execute_const current_state func
  | ParseTyped _ | ParseUntyped _ -> execute_parse current_state func
  | Env _ -> execute_env current_state func
  | _ -> raise (Exceptions.not_implemented_factory ())
;;

let terminate (line_number : int) (status : bool) =
  if status
  then Printf.printf "Gracefully finished execution at line %d\n" line_number
  else (
    Printf.printf "Program failed execution at line %d\n" line_number;
    raise (Exceptions.program_failed_exception_factory ()))
;;

let rec run_program
          (line_number : int)
          (program : conkeldurr_function list)
          (state : global_state_t)
  : global_state_t
  =
  Printf.printf "Executing line %d\n" line_number;
  match program with
  | [] ->
    terminate line_number true;
    state
  | head :: rest ->
    head
    |> execute_function state
    |> fun (result, new_state) ->
    if result
    then run_program (line_number + 1) rest new_state
    else (
      terminate line_number false;
      state)
;;

let empty_state (size : int) : global_state_t =
  let mt_var_store = Hashtbl.create size in
  let mt_spr_store = Hashtbl.create size in
  let mt_env_store = Hashtbl.create size in
  mt_var_store, mt_spr_store, mt_env_store
;;

(* todo: make sure variables don't overwrite, no need for scoping *)
let run (program : conkeldurr_function list) : global_state_t =
  run_program 1 program (empty_state (List.length program))
;;
