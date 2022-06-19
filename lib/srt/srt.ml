type subtitle = { text: string }

let count_character (c: char) (s: string): int =
  let total = ref 0 in
  for i = 0 to (String.length s) - 1 do
    if s.[i] == c then
      total := !total + 1
  done;
  !total

let extract_text (c: char) (str: string) =
  let lst = String.split_on_char c str in
  if (List.length lst) >= 3 then
    let text = lst
    |> List.tl
    |> List.tl
    |> List.map String.trim 
    |> String.concat "\n"
  in
  Some {text}
  else None

let parse_subtitle (sub: string): subtitle option =
  let carriage_returns = count_character '\r' sub in
  let newlines = count_character '\n' sub in
  if carriage_returns > newlines then
    extract_text '\r' sub
  else
    extract_text '\n' sub

let parse_from_string (file_contents: string): subtitle list =
  let carriage_returns = count_character '\r' file_contents in
  let newlines = count_character '\n' file_contents in
  if carriage_returns > newlines then
    file_contents
    |> Re.split ("\r\r" |> Re.Posix.re |> Re.Posix.compile)
    |> List.map String.trim
    |> List.map (fun x -> extract_text '\r' x)
    |> List.filter Option.is_some
    |> List.map Option.get
  else if newlines > carriage_returns then
    file_contents
    |> Re.split ("\n\n" |> Re.Posix.re |> Re.Posix.compile)
    |> List.map String.trim
    |> List.map (fun x -> extract_text '\n' x)
    |> List.filter Option.is_some
    |> List.map Option.get
  else
    file_contents
    |> Re.split ("\r\n\r\n" |> Re.Posix.re |> Re.Posix.compile)
    |> List.map String.trim
    |> List.map (fun x -> extract_text '\n' x)
    |> List.filter Option.is_some
    |> List.map Option.get

let parse_from_file (filename: string): subtitle list =
  In_channel.with_open_bin filename In_channel.input_all
  |> parse_from_string