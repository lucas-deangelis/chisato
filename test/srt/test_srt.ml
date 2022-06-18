open Srt
 
let generate_test (separator: string) =
  let text = ["This is a subtitle text"; "This is a second line"] in
  let input = String.concat separator (["1"; "00:00:07,001 --> 00:00:09,015 position:50,00%,middle align:middle size:80,00% line:84,67%"] @ text) in
  let res = parse_subtitle input in
  Alcotest.(check string) "same string" (String.concat "\n" text) (Option.get res).text

let test_text () = generate_test "\n"

let test_text_carriage_return () = generate_test "\r"

let test_text_carriage_return_and_newline () = generate_test "\r\n"

let generate_test_file (separator: string) =
  let first_sub_text =  ["This is a subtitle text"; "This is a second line"] in
  let second_sub_text = ["The second subtitle"; "Second subtitle, second line"] in
  let first_sub = String.concat separator (["1"; "00:00:07,001 --> 00:00:09,015 position:50,00%,middle align:middle size:80,00% line:84,67%"] @ first_sub_text) in
  let second_sub = String.concat separator (["2"; "00:00:07,001 --> 00:00:09,015 position:50,00%,middle align:middle size:80,00% line:84,67%"] @ second_sub_text) in
  let input = String.concat (separator ^ separator) [first_sub; second_sub] in
  let res = parse_file_contents input in
  Alcotest.(check (list string)) "same string" [("This is a subtitle text\nThis is a second line"); ("The second subtitle\nSecond subtitle, second line")] (List.map (fun x -> x.text) res)

let test_file () = generate_test_file "\n"

let test_file_carriage_return () = generate_test_file "\r"

let test_file_carriage_return_and_newline () = generate_test_file "\r\n"

let () =
  let open Alcotest in
  run "subtitles" [
    "subtitle", [
      test_case "Two lines of text, newline only" `Quick test_text;
      test_case "Two lines of text, carriage return only" `Quick test_text_carriage_return;
      test_case "Two lines of text, carriage return and newline" `Quick test_text_carriage_return_and_newline;
      test_case "A file, newline only" `Quick test_file;
      test_case "A file, carriage return only" `Quick test_file_carriage_return;
      test_case "A file, carriage return and newline" `Quick test_file_carriage_return_and_newline;
    ]
  ]
