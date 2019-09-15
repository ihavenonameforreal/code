require 'execjs'

class Code
  class Application
    def initialize(path)
      @path = path
      @name = @path.split('/').last
      @history_path = "#{@path}/history.data"
      @data_path = "#{@path}/#{@name}.data"
    end

    def self.start(path)
      new(path).start
    end

    def start
      loop do
        print '> '
        Code::Evaluator.eval(STDIN.gets.strip,
          data_path: @data_path,
          history_path: @history_path
        )
      end
    end
  end
end
