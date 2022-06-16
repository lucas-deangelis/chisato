type subtitle = {text: string}

let get_text re line =
  let ex = Re.exec_opt re line in
  match ex with
  | Some x -> Re.Group.get_opt x 1
  | None -> None
  

let parse_file_contents (s: string): subtitle list =
  let reg = "Dialogue:.*,(.*)$" |> Re.Posix.re |> Re.Posix.compile in
  s
  |> String.split_on_char '\n'
  |> List.map (fun line -> get_text reg line)
  |> List.filter Option.is_some
  |> List.map (fun text -> {text = Option.get text})
