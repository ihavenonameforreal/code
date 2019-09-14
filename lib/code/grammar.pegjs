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
number = $[0-9]+

value = $character+

give = "donner"
to = "à"

instruction =
  give
  space
  number:number
  space
  to
  space
  name:value
  { return { number: number, name: name } }
