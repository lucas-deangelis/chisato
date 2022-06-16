type subtitle = { text: string list }

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
    |> List.map String.trim in
  Some {text}
  else None

let parse_subtitle (sub: string): subtitle option =
  let carriage_returns = count_character '\r' sub in
  let newlines = count_character '\n' sub in
  if carriage_returns > newlines then
    extract_text '\r' sub
  else
    extract_text '\n' sub

let parse_file_contents (file_contents: string): subtitle option list =
  let carriage_returns = count_character '\r' file_contents in
  let newlines = count_character '\n' file_contents in
  if carriage_returns > newlines then
    file_contents
    |> Re.split ("\r\r" |> Re.Posix.re |> Re.Posix.compile)
    |> List.map String.trim
    |> List.map (fun x -> extract_text '\r' x)
  else if newlines > carriage_returns then
    file_contents
    |> Re.split ("\n\n" |> Re.Posix.re |> Re.Posix.compile)
    |> List.map String.trim
    |> List.map (fun x -> extract_text '\n' x)
  else
    file_contents
    |> Re.split ("\r\n\r\n" |> Re.Posix.re |> Re.Posix.compile)
    |> List.map String.trim
    |> List.map (fun x -> extract_text '\n' x)
