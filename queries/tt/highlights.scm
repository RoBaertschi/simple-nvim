[
 "true"
 "false"
 ] @boolean


"fn" @keyword.function
[
 "if"
 "in"
 "else"
 ] @keyword.conditional

[
 "=="
 "!="
 ">"
 ">="
 "<"
 "<="
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
