[
 (block_expression)
 ] @local.scope

(function_declaration name: (identifier) @local.definition.function (#set! definition.var.scope "parent"))

(argument name: (identifier) @local.definition.var)
(variable_declaration name: (identifier) @local.definition.var)
(variable_reference) @local.reference
