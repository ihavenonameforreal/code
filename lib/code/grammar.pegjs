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

give = "give"
to = "to"
from = "from"
_for = "for"
exit = "exit"
help = "help"
show = "show"
reset = "reset"
history = "history"
define = "define"
as = "as"

zero = "zero" { return 0 }
one = "one" { return 1 }
two = "two" { return 2 }
three = "three" { return 3 }
four = "four" { return 4 }
five = "five" { return 5 }
six = "six" { return 6 }
seven = "seven" { return 7 }
eight = "eight" { return 8 }
nine = "nine" { return 9 }
ten = "ten" { return 10 }
eleven = "eleven" { return 11 }
twelve = "twelve" { return 12 }
thirsteen = "thirsteen" { return 13 }
fourteen = "fourteen" { return 14 }
fifthteen = "fifthteen" { return 15 }
sixteen = "sixteen" { return 16 }
seventeen = "seventeen" { return 17 }
eighteen = "eighteen" { return 18 }
nineteen = "nineteen" { return 19 }
twenty = "twenty" { return 20 }

literal =
  zero / one / two / three / four / six / seven / eight / nine / ten
  eleven / twelve / thirsteen / fifthteen / sixteen / seventeen /
  eighteen / nineteen / twelve

keyword = to / from / _for / as

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
    define
    space
    name:name
    space
    definition:(
      as
      space
      _definition:name
      { return _definition }
    )?
    { return { verb: "define", name, definition } }
  ) / (
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
