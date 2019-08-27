require 'execjs'

class Code
  class Application
    def initialize(path)
      @path = path
      @name = @path.split('/').last
      @definitions_path = "#{@path}/#{@name}.definitions"
      @code_path = "#{@path}/#{@name}.code"
      @data_path = "#{@path}/#{@name}.data"
    end

    def self.start(path)
      new(path).start
    end

    def definitions
      File.read(@definitions_path)
    end

    def code
      File.read(@code_path)
    end

    def data
      File.read(@data_path)
    end

    def start
      Code::Evaluator.eval(
        definitions + "\n" + code,
        data: Code::Data.load(data)
      )
    end
  end
end
