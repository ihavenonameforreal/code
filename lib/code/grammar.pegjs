code =
  (space / newline)
  { return [] } /
  (
    ws
    firstInstruction:instruction
    otherInstructions:(
      ws newline ws
      otherInstruction:instruction
      { return otherInstruction }
    )*
    (space / newline)*
    {
      return [firstInstruction].concat(
        otherInstructions
      )
    }
  )

ws = " "*
space = " "+
newline = [\n,;]
character = [a-z]
number = [0-9]

instruction =
  verb:verb space
  quantity:quantity space
  link:link space
  value:value
  { return { verb: verb, quantity: quantity, link:link, value:value } }

verb = $character+
quantity = $number+
link = $character+
value = $character+
