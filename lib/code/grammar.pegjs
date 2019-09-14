code =
  ws
  first:instruction?
  others:(
    ws
    newline ws
    other:instruction
    { return other }
  )*
  (space / newline)*
  { return [first].concat(others) }

ws = " "*
space = " "+
newline = [\n;]
character = [a-zA-Z0-9àéè]
quantity = $[0-9]+

value = $character+

give = "donner"
to = "à"

instruction =
  give
  space
  quantity:quantity
  space
  to
  space
  name:value
  { return { quantity, name } }
