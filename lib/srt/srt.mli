type subtitle = {text: string}

val parse_subtitle : string -> subtitle option

val parse_from_string : string -> subtitle list

val parse_from_file : string -> subtitle list
