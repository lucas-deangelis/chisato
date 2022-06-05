open Subtitles

let input = "1\n00:00:07,001 --> 00:00:09,015 position:50,00%,middle align:middle size:80,00% line:84,67%\nThis is a subtitle text"

let res = parse_subtitle input

let () = assert ((Option.get res).text = "tota")