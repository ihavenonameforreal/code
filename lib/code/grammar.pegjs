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
word = $character+
open_parenthesis = "("
close_parenthesis = ")"

define = "define"
as = "as"
_in = "in"
ruby = "ruby"
end = "end"
_of = "of"

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
    name:name
    definition:(
      space
      as
      space
      _definition:(
        open_parenthesis ws
        _in space ruby ws
        close_parenthesis
        newline ws
        code:$(!open_parenthesis name)
        newline
        open_parenthesis ws
        end space _of space ruby ws
        close_parenthesis ws
        { return { language: "ruby", code: code } }
        /
        code:name
        { return { language: "code", code: code } }
      )
      { return _definition }
    )?
    { return { verb: "define", name, definition } }
  )
