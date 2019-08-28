code =
  (space / newline)
  { return [] } / // empty file
  (
    ws
    first:instruction
    others:(
      ws newline ws
      other:instruction
      { return other }
    )*
    (space / newline)*
    { return [first].concat(others) }
  )

ws = " "*
space = " "+
newline = [\n;]
character = [a-zA-Zàéè]
number =$([0-9]+ ([.,] [0-9]+)?)

instruction =
  verb:verb space
  quantity:quantity space
  link:link space
  value:value
  { return { verb: verb, link:link, value:value } }

verb = $character+
quantity = $number+
link = $character+
value = $character+
