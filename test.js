#!/usr/bin/env node

process = require("process")

let Parser = require("./lib/code/parser.js").Parser

let samples = [
//  "give 1",
//  "help",
//  "exit",
//  "show",
//  "give 10 to dorian michel marié",
//  "give 0 to angélique from dorian",
//  "give 3 potatoes to laurie marié from dorian marié for the water",
//  "give three glasses of water to damien",
//  "define a person as an object",
`define show a string as (in ruby) puts string
define a person as an object`
]

for (sample of samples) {
  try {
    tree = Parser.parse(sample)
    console.log(JSON.stringify(tree, null, 2))
  } catch(e) {
    console.log(sample)
    column = e.location.start.column
    arrow = ""
    for (i = 1; i < column; i += 1) {
      arrow = arrow + "-"
     }
    console.log(arrow + '^')
    console.log(`line ${e.location.start.line}`)
    console.log(e.message)
    process.exit(0)
  }
}
