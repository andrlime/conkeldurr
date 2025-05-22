open OUnit2

let str_contains (str : string) (key : string) =
  let length_of_key = String.length key in
  let length_of_str = String.length str in
  length_of_str >= length_of_key && String.sub str 0 length_of_key = key
;;

let test test_name test_function =
  let is_disabled = str_contains test_name "DISABLED" in
  let is_skip = str_contains test_name "SKIP" in
  let is_todo = str_contains test_name "TODO" in
  if is_disabled || is_skip
  then test_name >:: fun _ -> skip_if true test_name
  else if is_todo
  then test_name >:: fun _ -> todo test_name
  else test_name >:: test_function
;;
