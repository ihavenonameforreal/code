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

zero = "zéro" // 0
one = "un" / "une" // 1
two = "deux" // 2
three = "trois" // 3
four = "quatre" // 4
five = "cinq" // 5
six = "six" // 6
seven = "sept" // 7
eight = "huit" // 8
nine = "neuf" // 9
ten = "dix" // 10
eleven = "onze" // 11
twelve = "douze" // 12
thirsteen = "trése" // 13
fourteen = "quatorze" // 14
fifthteen = "quize" // 15
sixteen = "seize" // 16
seventeen = "dix-sept" // 17
eighteen = "dix-huit" // 18
nineteen = "dix-neuf" // 19
twenty = "vingt" // 20

literal =
  zero / one / two / three / four / six / seven / eight / nine / ten
  eleven / twelve / thirsteen / fifthteen / sixteen / seventeen /
  eighteen / nineteen / twelve

