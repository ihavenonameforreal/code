require 'execjs'

class Code
  class Evaluator
    def initialize(text, data_path: nil, journal_path: nil)
      @text = text
      @parsed = Code::Parser.parse(text)
      @data_path = data_path
      @data = data_path ? Code::Data.load(File.read(data_path)) : {}
      @journal_path = journal_path
      @journal = journal_path ? Code::Data.load(File.read(journal_path)) : []
    end

    def self.eval(text, data_path: nil, journal_path: nil)
      new(text, data_path: data_path, journal_path: nil).eval
    end

    def eval
      @parsed.each.with_index do |line, index|
        @journal << { line: line, time: Time.now, index: index }

        if line["verb"] == "donner"
          @data[line["value"]] ||= 0
          @data[line["value"]] += line["quantity"].to_f
        else
          abort "not supported"
        end

        if @data_path
          File.write(@data_path, Code::Data.dump(@data))
        end

        if @journal_path
          File.write(@journal_path, Code::Data.dump(@journal))
        end
      end
    end
  end
end

