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
before = "un " / "une " / "le " / "la " / "l'" / "les"
exit = "exit"
help = "aide" / "help"
show = "afficher"
reset = "recommencer"
history = "historique"

instruction =
  (
    give
    space
    quantity:quantity
    name:(
      space
      to
      space
      _name:name
      { return _name }
    )?
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
    { return { verb: "give", quantity, name, from, for: _for } }
  ) / (
    exit
    { return { verb: "exit" } }
  ) / (
    help
    { return { verb: "help" } }
  ) / (
    show
    { return { verb: "show" } }
  ) / (
    reset
    { return { verb: "reset" } }
  ) / (
    history 
    { return { verb: "history" } }
  )
