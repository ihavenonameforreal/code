#!/bin/bash

pegjs \
  --format globals \
  --export-var Parser \
  --output lib/code/parser.js \
  lib/code/grammar.pegjs
