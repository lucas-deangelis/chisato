type subtitle = {text: string}

let count_character (c: char) (s: string): int =
  let total = ref 0 in
  for i = 0 to (String.length s) - 1 do
    if s.[i] == c then
      total := !total + 1
  done;
  !total

let get_text re line =
  let ex = Re.exec_opt re line in
  match ex with
  | Some x -> Re.Group.get_opt x 1
  | None -> None
  

let parse_from_string (s: string): subtitle list =
  let carriage_returns = count_character '\r' s in
  let newlines = count_character '\n' s in
  let reg = "Dialogue:.*,(.*)$" |> Re.Posix.re |> Re.Posix.compile in
  if newlines > carriage_returns then
  s
  |> String.split_on_char '\n'
  |> List.map (fun line -> get_text reg line)
  |> List.filter Option.is_some
  |> List.map (fun text -> {text = Option.get text})
  else if carriage_returns > newlines then
  s
  |> String.split_on_char '\r'
  |> List.map (fun line -> get_text reg line)
  |> List.filter Option.is_some
  |> List.map (fun text -> {text = Option.get text})
  else
  s
  |> String.split_on_char '\r'
  |> List.map String.trim
  |> List.map (fun line -> get_text reg line)
  |> List.filter Option.is_some
  |> List.map (fun text -> {text = Option.get text})

let parse_from_file (filename: string): subtitle list =
  In_channel.with_open_bin filename In_channel.input_all
  |> parse_from_string