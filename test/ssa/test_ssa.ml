open Ssa

let string_list_of_subtitle_list = List.map (fun s -> s.text)

let generate_test (separator: string) =
  let file = "Comment: 0,0:00:00.00,0:00:00.00,*Default,NTP,0000,0000,0000,,A comment" ^ separator ^ "Dialogue: 0,0:00:01.78,0:00:04.80,*Default,NTP,0000,0000,0000,,A line" ^ separator ^ "Dialogue: 0,0:00:05.20,0:00:07.88,*Default,NTP,0000,0000,0000,,Another line" in
  let res = string_list_of_subtitle_list (Ssa.parse_file_contents file) in
  let answer = string_list_of_subtitle_list ([{text = "A line"}; {text = "Another line"}]) in
  Alcotest.(check (list string)) "same string" answer res

let test_file () = generate_test "\n"
let test_file_carriage_return  () = generate_test "\r"
let test_file_carriage_return_and_newline () = generate_test "\r\n"

let () =
  let open Alcotest in
  run "subtitles" [
    "subtitle", [
      test_case "A file, with newlines" `Quick test_file;
      test_case "A file, with carriage returns" `Quick test_file_carriage_return;
      test_case "A file, with carriage returns and newlines" `Quick test_file_carriage_return_and_newline;
    ]
  ]
