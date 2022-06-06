type subtitle = {text: string list}

val parse_subtitle : string -> subtitle option

val parse_file_contents : string -> subtitle option list
