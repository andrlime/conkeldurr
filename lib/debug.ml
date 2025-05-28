open Types

let print_state (global_state : global_state_t) : int =
  let vars, spreadsheets, envs = global_state in
  Printf.printf "---PRINTING VARIABLE STORE---\n";
  Hashtbl.iter
    (fun k v ->
       Printf.printf "variable %s\n" k;
       match v with
       | Number v -> Printf.printf "value(number) %s\n\n" v
       | String v -> Printf.printf "value(string) %s\n\n" v)
    vars;
  Printf.printf "---END---\n\n";
  Printf.printf "---PRINTING SPREADSHEET STORE---\n";
  Hashtbl.iter
    (fun k v ->
       let var_name, interface_name = k in
       Printf.printf "spreadsheet %s\tinterface %s\n" var_name interface_name;
       v |> List.iter Read_csv_spreadsheet.print_column)
    spreadsheets;
  Printf.printf "---END---\n\n";
  Printf.printf "---PRINTING ENV STORE---\n";
  Hashtbl.iter (fun k v -> Printf.printf "%s\t->\t%s\n" k v) envs;
  Printf.printf "---END---\n\n";
  0
;;
