require 'execjs'

class Code
  class Application
    def initialize(path)
      @path = path
      @name = @path.split('/').last
      @journal_path = "#{@path}/#{@name}.journal"
      @data_path = "#{@path}/#{@name}.data"
    end

    def self.start(path)
      new(path).start
    end

    def start
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
