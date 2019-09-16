#!/usr/bin/env node

Parser = require("./lib/code/parser.js").Parser

samples = [
  "donner 1",
  "donner 10 à dorian",
  "donner 0 à angélique de dorian",
  "donner 3 à laurie de dorian pour l'eau",
  "aide",
  "quitter",
  "afficher",
]

for (sample of samples) {
  console.log("\n### " + sample + "\n")
  tree = Parser.parse(sample)
  console.log(JSON.stringify(tree, null, 2))
}
