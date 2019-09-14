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

link = "à" / "de" / "avec" / "dans"
before = "le" / "la" / "un" / "une"

verb = $character+
value = $character+

give = "donner"

instruction =
  give
  space
  number:number
  space
  parameters:(
    link:link space
    before:before?
    other:value
    { return { link: link, value: other } }
  )*
  { return { number: number, parameters: parameters } }
