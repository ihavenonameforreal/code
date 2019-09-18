#!/usr/bin/env node

Parser = require("./lib/code/parser.js").Parser
process = require("process")

samples = [
  "give 1",
  "help",
  "exit",
  "show",
  "give 10 to dorian michel marié",
  "give 0 to angélique from dorian",
  "give 3 patates to laurie marié from dorian marié for l'eau",
  "give three verres d'eau to damien",
  "define a person as un objet",
  "define show as show; show"
]

for (sample of samples) {
  console.log("\n### " + sample + "\n")
  try {
    tree = Parser.parse(sample)
    console.log(JSON.stringify(tree, null, 2))
  } catch(e) {
    console.log(e.message)
    console.log(sample)
    offset = e.location.start.offset
    arrow = ""
    for (i = 1; i < offset; i += 1) {
      arrow = arrow + "-"
     }
    console.log(arrow + '^')
    console.log(JSON.stringify(e, null, 2))
    process.exit(0)
  }
}
