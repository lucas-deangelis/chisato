type subtitle = { text: string list }

let parse_subtitle (sub: string): subtitle option =
  let lst = String.split_on_char '\n' sub in
  if (List.length lst) >= 3 then
  Some {text = (List.tl (List.tl (List.tl lst)))}
  else None