require 'execjs'

class Code
  class Evaluator
    def initialize(text, data_path: nil, journal_path: nil)
      @text = text
      @parsed = Code::Parser.parse(text)
      @data_path = data_path
      @data = data_path ? Code::Data.load(read_file(data_path)) : {}
      @journal_path = journal_path
      @journal = journal_path ? Code::Data.load(read_file(journal_path)) : []
    end

    def read_file(filepath)
      if File.exists?(filepath)
        File.read(filepath)
      else
        File.write("", filepath)
      end
    end

    def self.eval(text, data_path: nil, journal_path: nil)
      new(text, data_path: data_path, journal_path: nil).eval
    end

    def eval
      @parsed.each.with_index do |line, index|
        @journal << { line: line, time: Time.now, index: index }

        @data[line["name"]] ||= 0
        @data[line["name"]] += line["quantity"].to_f

        if @data_path
          File.write(@data_path, Code::Data.dump(@data))
        else
          p @data
        end

        if @journal_path
          File.write(@journal_path, Code::Data.dump(@journal))
        end
      end
    end
  end
end

