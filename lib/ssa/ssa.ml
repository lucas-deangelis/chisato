type subtitle = {text: string}

let count_character (c: char) (s: string): int =
  let total = ref 0 in
  for i = 0 to (String.length s) - 1 do
    if s.[i] == c then
      total := !total + 1
  done;
  !total

let commas_in_format (s: string): int =
  let reg = Str.regexp {|\[Events\]\nFormat.*\n|} in
  let _ = Str.search_forward reg s 0 in
  Str.matched_string s
  |> count_character ','

let parse_file_contents (s: string): subtitle list =
  let commas = commas_in_format s in
  (* Something something scanf here, since I didn't found a way to get all matches of a regex *)