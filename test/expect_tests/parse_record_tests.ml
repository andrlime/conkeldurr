open Conkeldurr

let%expect_test "parse records from csv string" =
  let csv =
    Spreadsheet.Csv0.from_string
      {|
      (String a),(String b),(String c),(Float ab),(Integer bc),(Boolean cd)
      A,B,C,1.0,2,false
      D,E,F,3.1,33,true
      |}
  in
  csv.records |> List.map Record.T.to_string |> List.iter print_endline;
  [%expect
    {|
  (((name a)(value(String A)))((name b)(value(String B)))((name c)(value(String C)))((name ab)(value(Float 1)))((name bc)(value(Integer 2)))((name cd)(value(Boolean false))))
  (((name a)(value(String D)))((name b)(value(String E)))((name c)(value(String F)))((name ab)(value(Float 3.1)))((name bc)(value(Integer 33)))((name cd)(value(Boolean true))))
  |}]
;;

let%expect_test "parse records from csv file" =
  let csv = Spreadsheet.Csv0.from_path "./cases/data/sample_spreadsheet.csv" in
  csv.records |> List.map Record.T.to_string |> List.iter print_endline;
  [%expect
    {|
  (((name a)(value(String A)))((name b)(value(String B)))((name c)(value(String C)))((name ab)(value(Float 1)))((name bc)(value(Integer 2)))((name cd)(value(Boolean false))))
  (((name a)(value(String D)))((name b)(value(String E)))((name c)(value(String F)))((name ab)(value(Float 3.1)))((name bc)(value(Integer 33)))((name cd)(value(Boolean true))))
  |}]
;;

let%expect_test "parse string column" =
  let csv =
    Spreadsheet.Csv0.from_string
      {|
      (String a)
      A
      B
      C
      Longer string
      "string with a comma,"
      |}
  in
  csv.records |> List.map Record.T.to_string |> List.iter print_endline;
  [%expect
    {|
    (((name a)(value(String A))))
    (((name a)(value(String B))))
    (((name a)(value(String C))))
    (((name a)(value(String"Longer string"))))
    (((name a)(value(String"string with a comma,"))))
  |}]
;;

let%expect_test "parse int column" =
  let csv =
    Spreadsheet.Csv0.from_string
      {|
      (Integer a)
      12
      24
      |}
  in
  csv.records |> List.map Record.T.to_string |> List.iter print_endline;
  [%expect
    {|
    (((name a)(value(Integer 12))))
    (((name a)(value(Integer 24))))
  |}]
;;

let%expect_test "parse float column" =
  let csv =
    Spreadsheet.Csv0.from_string
      {|
      (Float a)
      12
      2.3
      3.14
      |}
  in
  csv.records |> List.map Record.T.to_string |> List.iter print_endline;
  [%expect
    {|
    (((name a)(value(Float 12))))
    (((name a)(value(Float 2.3))))
    (((name a)(value(Float 3.14))))
  |}]
;;

let%expect_test "parse number column" =
  let csv =
    Spreadsheet.Csv0.from_string
      {|
      (Number a)
      1
      2.3
      3.14
      22
      19
      |}
  in
  csv.records |> List.map Record.T.to_string |> List.iter print_endline;
  [%expect
    {|
    (((name a)(value(Float 1))))
    (((name a)(value(Float 2.3))))
    (((name a)(value(Float 3.14))))
    (((name a)(value(Float 22))))
    (((name a)(value(Float 19))))
  |}]
;;

let%expect_test "parse boolean column" =
  let csv =
    Spreadsheet.Csv0.from_string
      {|
      (Boolean a)
      fdsafsdadfas
      FALSE
      falSE
      trUE
      treu
      1
      0
      213312
      |}
  in
  csv.records |> List.map Record.T.to_string |> List.iter print_endline;
  [%expect
    {|
    (((name a)(value(Boolean true))))
    (((name a)(value(Boolean false))))
    (((name a)(value(Boolean false))))
    (((name a)(value(Boolean true))))
    (((name a)(value(Boolean true))))
    (((name a)(value(Boolean true))))
    (((name a)(value(Boolean false))))
    (((name a)(value(Boolean true))))
  |}]
;;

let%expect_test "parse float fails on invalid number" =
  try
    ignore
      (Spreadsheet.Csv0.from_string
         {|
      (Float a)
      1.1a
      |})
  with
  | Invalid_argument msg ->
    print_endline msg;
    [%expect {| Cannot parse 1.1a to float |}]
;;

let%expect_test "parse int fails on float" =
  try
    ignore
      (Spreadsheet.Csv0.from_string
         {|
      (Integer a)
      1.1
      |})
  with
  | Invalid_argument msg ->
    print_endline msg;
    [%expect {| Cannot parse 1.1 to int |}]
;;

let%expect_test "parse int fails on invalid number" =
  try
    ignore
      (Spreadsheet.Csv0.from_string
         {|
      (Integer a)
      hello world
      |})
  with
  | Invalid_argument msg ->
    print_endline msg;
    [%expect {| Cannot parse hello world to int |}]
;;

let%expect_test "parse number fails on invalid number" =
  try
    ignore
      (Spreadsheet.Csv0.from_string
         {|
      (Number a)
      hello world
      |})
  with
  | Invalid_argument msg ->
    print_endline msg;
    [%expect {| Cannot parse hello world to float |}]
;;
