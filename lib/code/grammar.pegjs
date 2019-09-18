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
quantity = number / literal
number = $[0-9]+
word = $character+

give = "donner"
to = "à"
from = "de"
_for = "pour"
exit = "quitter"
help = "aide"
show = "afficher"
reset = "recommencer"
history = "historique"

zero = "zéro" { return 0 }
one = "un" / "une" { return 1 }
two = "deux" { return 2 }
three = "trois" { return 3 }
four = "quatre" { return 4 }
five = "cinq" { return 5 }
six = "six" { return 6 }
seven = "sept" { return 7 }
eight = "huit" { return 8 }
nine = "neuf" { return 9 }
ten = "dix" { return 10 }
eleven = "onze" { return 11 }
twelve = "douze" { return 12 }
thirsteen = "trése" { return 13 }
fourteen = "quatorze" { return 14 }
fifthteen = "quize" { return 15 }
sixteen = "seize" { return 16 }
seventeen = "dix-sept" { return 17 }
eighteen = "dix-huit" { return 18 }
nineteen = "dix-neuf" { return 19 }
twenty = "vingt" { return 20 }

literal =
  zero / one / two / three / four / six / seven / eight / nine / ten
  eleven / twelve / thirsteen / fifthteen / sixteen / seventeen /
  eighteen / nineteen / twelve


keyword = to / from / _for

name =
  first:(
    !keyword
    word:word
    { return word }
  )
  others:(
    space
    word:(
      !keyword
      word:word
      { return word }
    )
    { return word }
  )*
  { return [first, ...others].join(" ") }

instruction =
  (
    give
    space
    quantity:quantity
    unit:(
      space
      unit:name
      { return unit }
    )?
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
    { return { verb: "give", quantity, unit, to, from, for: _for } }
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
