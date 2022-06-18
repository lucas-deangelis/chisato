# Subtitles

A library to extract the text from various forms of subtitles.

## Features

- Extract text from `.srt` files, while handling all lines terminators (`\n`, `\r`, `\r\n`)
- Extract text from `.ass`/`.ssa` files

## Todo

### Before v1

- [x] Harmonize `parse_file_contents` and the `subtitle` type
- [ ] Support for `.ass`/`.ssa` files
  - [x] Basic support with `\n` line ending
  - [ ] Support for `\r`, `\r\n`
- [ ] Function that takes a filepath as parameter for convenience
- [ ] Executable that reads a file, recognizes the extension and prints out all the text
- [ ] Basic documentation

### More long term

- [ ] Extract more info from the subtitles (timing, position, will be type-dependant since different types of subtitles have different type of info)
- [ ] Manipulations of the subtitles (modify the timing, change the position)
- [ ] Extensive test suite (especially for `.srt` files that lack a precise spec)
- [ ] More subtitles types
