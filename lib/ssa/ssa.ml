type subtitle = {text: string list}

let parse_subtitle (s: string): subtitle option =
  Some {text = [s]}

let parse_file_contents (s: string): subtitle option list =
  [Some {text = [s]}]