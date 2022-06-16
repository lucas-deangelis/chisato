open Ssa

let string_list_of_subtitle_list = List.map (fun s -> s.text)

let test_file () =
  let file = "Comment: 0,0:00:00.00,0:00:00.00,*Default,NTP,0000,0000,0000,,A comment\nDialogue: 0,0:00:01.78,0:00:04.80,*Default,NTP,0000,0000,0000,,A line\nDialogue: 0,0:00:05.20,0:00:07.88,*Default,NTP,0000,0000,0000,,Another line" in
  let res = string_list_of_subtitle_list (Ssa.parse_file_contents file) in
  let answer = string_list_of_subtitle_list ([{text = "A line"}; {text = "Another line"}]) in
  Alcotest.(check (list string)) "same string" answer res

let () =
  let open Alcotest in
  run "subtitles" [
    "subtitle", [
      test_case "A file" `Quick test_file;
    ]
  ]
