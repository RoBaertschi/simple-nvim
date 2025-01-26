[
 "true"
 "false"
 ] @boolean


"fn" @keyword.function

[
 "=="
 "!="
 "+"
 "-"
 "*"
 "/"
 "="
 ] @operator

"(" @punctuation.bracket
")" @punctuation.bracket
"{" @punctuation.bracket
"}" @punctuation.bracket
";" @punctuation.delimiter

(number) @number

(function_declaration name: (identifier) @function)
