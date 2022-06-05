type subtitle = { text: string }

let parse_subtitle (sub: string): subtitle option =
  let lst = String.split_on_char '\n' sub in
  if (List.length lst) >= 3 then
  Some {text = (List.nth lst 2)}
  else None