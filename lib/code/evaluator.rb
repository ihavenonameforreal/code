require 'execjs'

class Code
  class Evaluator
    def initialize(text, data: nil)
      @text = text
      @parsed = Code::Parser.parse(text)
      @data = data || {}
    end

    def self.eval(text, data: nil)
      new(text, data: data).eval
    end

    def eval
      @parsed.each do |line|
        if line["verb"] == "donner"
          @data[line["value"]] ||= 0
          @data[line["value"]] += line["quantity"].to_f
        else
          abort "not supported"
        end
      end

      p @data
    end
  end
end

