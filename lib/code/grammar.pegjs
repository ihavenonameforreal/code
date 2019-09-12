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

instruction =
  verb:verb
  space
  first:(
    value:value space
    { return { value: value } }
  )?
  others:(
    link:link space
    other:value
    { return { link: link, value: other } }
  )*
  { return { verb: verb, values: [first].concat(others) } }
