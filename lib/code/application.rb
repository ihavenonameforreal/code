require 'execjs'

class Code
  class Application
    def initialize(path)
      @path = path
      @name = @path.split('/').last
      @definitions_path = "#{@path}/#{@name}.definitions"
      @journal_path = "#{@path}/#{@name}.journal"
      @data_path = "#{@path}/#{@name}.data"
    end

    def self.start(path)
      new(path).start
    end

    def definitions
      File.read(@definitions_path)
    end

    def start
      Code::Evaluator.eval(definitions,
        data_path: @data_path,
        journal_path: @journal_path
      )
      
      loop do
        print '> '
        Code::Evaluator.eval(gets.strip,
          data_path: @data_path,
          journal_path: @journal_path
        )
      end
    end
  end
end
