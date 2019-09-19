// inspired from pegjs's examples/json.pegjs

data =
  ws value:value ws
  { return value }

begin_array = ws "[" ws
begin_object = ws "{" ws
end_array = ws "]" ws
end_object = ws "}" ws
name_separator  = ws ":" ws
value_separator = ws "," ws

ws "whitespace" = [ \t\n\r]*

value =
  null /
  true /
  false /
  object /
  array /
  number /
  string /
  short_object /
  short_array

null = "null" { return { value: "null" } }
false = "false" { return { value: "false" } }
true = "true" { return { value: "true" } }

