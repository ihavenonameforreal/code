#!/usr/bin/env ruby

require_relative 'code/parser'
require_relative 'code/evaluator'
require_relative 'code/application'
require_relative 'code/data'

class Code
  def self.parse(text)
    Code::Parser.parse(text)
  end

  def self.eval(text)
    Code::Evaluator.eval(text)
  end

  def self.start(path)
    Code::Application.start(path)
  end
end
