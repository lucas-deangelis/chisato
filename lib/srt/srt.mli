type subtitle = {text: string}

val parse_subtitle : string -> subtitle option

val parse_file_contents : string -> subtitle list
