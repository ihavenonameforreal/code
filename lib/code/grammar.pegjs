code =
  ws
  first:(definition / instruction)?
  others:(
    ws
    newline ws
    other:(definition / instruction)
    { return other }
  )*
  (space / newline)*
  { return [first].concat(others) }

ws = " "*
space = " "+
newline = [\n;]
character = [a-zA-Zàéè]
number = $([0-9]+ ([.,] [0-9]+)?)

link = "à" / "de" / "avec" / "dans"
define = "définir"
as = "comme étant"

verb = $character+
value = $character+

definition =
  define space
  value1:value space
  as space
  value2:value
  { return { value1: value1, value2: value2 } }

instruction =
  verb:verb space
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
