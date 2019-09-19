// inspired from https://raw.githubusercontent.com/pegjs/pegjs/master/examples/json.pegjs

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
  false /
  null /
  true /
  object /
  array /
  number /
  string /
  short_object /
  short_array
