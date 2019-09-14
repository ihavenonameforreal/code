#!/usr/bin/env node

Parser = require("./lib/code/parser.js").Parser

samples = [
  "donner 3 à laurie de la part de dorian pour l'eau",
]

for (sample of samples) {
  console.log("\n### " + sample + "\n")
  tree = Parser.parse(sample)
  console.log(JSON.stringify(tree, null, 2))
}
