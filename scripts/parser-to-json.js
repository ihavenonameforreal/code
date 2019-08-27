#!/usr/bin/env node

Parser = require("./../lib/code/parser.js").Parser

samples = [
  "donner 1 a dorian",
  "donner 2 a damien, donner 3 a dorian",
]

for (sample of samples) {
  console.log("\n### " + sample + "\n")
  tree = Parser.parse(sample)
  console.log(JSON.stringify(tree, null, 2))
}
