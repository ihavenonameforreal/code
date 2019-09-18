#!/usr/bin/env node

Parser = require("./lib/code/parser.js").Parser
process = require("process")

samples = [
  "donner 1",
  "aide",
  "quitter",
  "afficher",
  "donner 10 à dorian michel marié",
  "donner 0 à angélique de dorian",
  "donner 3 patates à laurie marié de dorian marié pour l'eau",
  "donner trois verres d'eau à damien",
  "définir une personne comme étant un objet",
  "définir afficher comme étant a; a"
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
