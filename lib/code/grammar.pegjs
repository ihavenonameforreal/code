code =
  ws
  head:instruction?
  ws
  tail:(
    ws
    newline ws
    other:instruction
    { return other }
  )*
  (space / newline)*
  { return [head, ...tail] }

ws = " "*
space = " "+
newline = [\n;]
character = [a-zA-Z0-9àéè']
ruby_character = [a-zA-Z0-9àéè'" =+-]
word = $character+
open_parenthesis = "("
close_parenthesis = ")"

define = "define"
as = "as"
_in = "in"
ruby = "ruby"
end = "end"
_of = "of"

before = "a" / "an" / "the"

keyword = as

name =
  head:(
    !keyword
    word:word
    { return word }
  )
  tail:(
    space
    word:(
      !keyword
      word:word
      { return word }
    )
    { return word }
  )*
  { return [head, ...tail].join(" ") }

instruction =
  (
    define
    space
    name:(
      before:(
        _before:before
        space
        { return _before }
      )?
      verb:word
      parameters:(
        space
        _before:before
        space
        name:name
        { return { before: _before, name: name } }
      )*
      { return { before, verb, parameters } }
    )
    definition:(
      space
      as
      space
      _definition:(
        open_parenthesis ws
        _in space ruby ws
        close_parenthesis
        space
        code:$ruby_character+
        { return { language: "ruby", code: code } }
        /
        code:name
        { return { language: "code", code: code } }
      )
      { return _definition }
    )?
    { return { verb: "define", name, definition } }
  )
