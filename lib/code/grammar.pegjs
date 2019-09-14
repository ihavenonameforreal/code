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

name = $character+

give = "donner"
to = "à"
from = "de la part de"
_for = "pour"
before = "un " / "une " / "le " / "la " / "l'"

instruction =
  give
  space
  quantity:quantity
  space
  to
  space
  name:name
  from:(
    space
    from
    space
    before?
    _name:name
    { return _name }
  )?
  _for:(
    space
    _for
    space
    before?
    _name:name
    { return _name }
  )?
  { return { quantity, name, from, for: _for } }
