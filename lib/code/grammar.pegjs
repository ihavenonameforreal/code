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
  { return [first, ...others] }

ws = " "*
space = " "+
newline = [\n;]
character = [a-zA-Z0-9àéè']
quantity = $[0-9]+

give = "donner"
to = "à"
from = "de la part de"
_for = "pour"
exit = "exit"
help = "aide" / "help"
show = "afficher"
reset = "recommencer"
history = "historique"

keyword = give / to / from / _for

word = $(!keyword character)+

name =
  first:word
  others:(
    space
    other:word
    { return other }
  )*
  { return [first, ...others] }

instruction =
  (
    give
    space
    quantity:quantity
    to:(
      space
      to
      space
      name:name
      { return name }
    )?
    from:(
      space
      from
      space
      name:name
      { return name }
    )?
    _for:(
      space
      _for
      space
      name:name
      { return name }
    )?
    { return { verb: "give", quantity, to, from, for: _for } }
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
