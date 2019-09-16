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
word = $character+
name = word // FIXME, multiple words

give = "donner"
to = "à"
from = "de"
_for = "pour"
exit = "quitter"
help = "aide"
show = "afficher"
reset = "recommencer"
history = "historique"

instruction =
  (
    give
    space
    quantity:quantity
    to:(
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
      _name:name
      { return _name }
    )?
    _for:(
      space
      _for
      space
      _name:name
      { return _name }
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
