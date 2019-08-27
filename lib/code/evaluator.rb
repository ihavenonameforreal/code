require 'execjs'

class Code
  class Evaluator
    def initialize(text, data_path: nil, journal_path: nil)
      @text = text
      @parsed = Code::Parser.parse(text)
      @data_path = data_path
      @data = data_path ? Code::Data.load(data_path) : {}
      @journal_path = journal_path
      @journal = journal_path ? Code::Data.load(journal_path) : []
    end

    def self.eval(text, data_path: nil, journal_path: nil)
      new(text, data_path: data_path, journal_path: nil).eval
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

