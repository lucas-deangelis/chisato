(lang dune 3.2)

(name subtitles)

(generate_opam_files true)

(source
 (github lucas-deangelis/subtitles))

(authors "Lucas DE ANGELIS <deangelis.lucas@outlook.com>")

(maintainers "Lucas DE ANGELIS <deangelis.lucas@outlook.com>")

(license LICENSE)

; (documentation "url to documentation")

(package
 (name subtitles)
 (synopsis "Extract text from subtitles files")
 (description "Extract text from subtitles files. Currently supports .srt and .ssa/.ass")
 (depends (ocaml (>= 4.08)) (dune (=> 3.2)) re (alcotest :with-test))
 (allow_empty))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
