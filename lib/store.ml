module T = struct
  type 'a t = { data : (string, 'a) Hashtbl.t }

  let[@inline] create () =
    let table = Hashtbl.create 97 in
    { data = table }
  ;;

  let[@inline] clear store = Hashtbl.clear store.data

  let set_key store key value =
    match Hashtbl.mem store.data key with
    | true -> failwith ("variable " ^ key ^ " already set")
    | false -> Hashtbl.add store.data key value
  ;;

  let[@inline] get_key store key = Hashtbl.find store.data key
  let[@inline] to_list store = Hashtbl.fold (fun k v acc -> (k, v) :: acc) store.data []

  let to_string store generator =
    store
    |> to_list
    |> List.map generator
    |> List.sort String.compare
    |> String.concat "\n"
    |> String.trim
  ;;
end
