type subtitle = { text: string }

let parse_subtitle (_: string): subtitle option =
  Some {text = "toto"}