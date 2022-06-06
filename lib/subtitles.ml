type subtitle = { text: string list }

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
  let carriage_returns = String.fold_left (fun acc el -> if el = '\r' then acc + 1 else acc) 0 sub in
  let newlines = String.fold_left (fun acc el -> if el = '\n' then acc + 1 else acc) 0 sub in
  if carriage_returns > newlines then
    extract_text '\r' sub
  else
    extract_text '\n' sub

let parse_file_contents (file_contents: string): subtitle option list =
  let carriage_returns = String.fold_left (fun acc el -> if el = '\r' then acc + 1 else acc) 0 file_contents in
  let newlines = String.fold_left (fun acc el -> if el = '\n' then acc + 1 else acc) 0 file_contents in
  if carriage_returns > newlines then
    file_contents
    |> Str.split (Str.regexp "\r\r")
    |> List.map String.trim
    |> List.map (fun x -> extract_text '\r' x)
  else if newlines > carriage_returns then
    file_contents
    |> Str.split (Str.regexp "\n\n")
    |> List.map String.trim
    |> List.map (fun x -> extract_text '\n' x)
  else
    file_contents
    |> Str.split (Str.regexp "\r\n\r\n")
    |> List.map String.trim
    |> List.map (fun x -> extract_text '\n' x)
