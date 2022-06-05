open Subtitles

let test_text () =
  let input = "1\n00:00:07,001 --> 00:00:09,015 position:50,00%,middle align:middle size:80,00% line:84,67%\nThis is a subtitle text" in
  let res = parse_subtitle input in
  Alcotest.(check (list string)) "same string" ["This is a subtitle text"] (Option.get res).text
 
let test_text_2 () =
  let input = "1\n00:00:07,001 --> 00:00:09,015 position:50,00%,middle align:middle size:80,00% line:84,67%\nThis is a subtitle text\nThis is a second line" in
  let res = parse_subtitle input in
  Alcotest.(check (list string)) "same string" ["This is a subtitle text"; "This is a second line"] (Option.get res).text

(** Check that we can handle files with \r\n *)
(** Check that we can handle whole files files with \n *)
(** Check that we can handle whole files files with \r\n *)

let () =
  let open Alcotest in
  run "subtitles" [
    "base", [
      test_case "test text 1" `Quick test_text;
      test_case "test text 2" `Quick test_text_2;
    ]
  ]