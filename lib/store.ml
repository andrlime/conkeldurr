module T = struct
  type 'a t = { data : (string, 'a) Hashtbl.t }

  type result =
    | Success
    | Failure of string

  let create () =
    let table = Hashtbl.create 97 in
    { data = table }
  ;;

  let set_key store key value =
    match Hashtbl.mem store.data key with
    | true -> Failure ("variable " ^ key ^ " already set")
    | false ->
      Hashtbl.add store.data key value;
      Success
  ;;

  let get_key store key =
    ignore (Hashtbl.find store.data key);
    Success
  ;;

  let to_list store = Hashtbl.fold (fun k v acc -> (k, v) :: acc) store.data []

  let to_string store generator =
    store
    |> to_list
    |> List.map generator
    |> List.sort String.compare
    |> String.concat "\n"
  ;;
end
