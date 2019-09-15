require 'execjs'
require "readline"

class Code
  class Application
    VERBS = [
      "donner", "afficher", "aide", "exit"
    ].sort

    COMPARE = proc { |verb| VERBS.grep(/^#{Regexp.escape(verb)}/) }

    def initialize(path)
      @path = path
      @name = @path.split('/').last
      @history_path = "#{@path}/history.data"
      @data_path = "#{@path}/#{@name}.data"

      Readline.completion_append_character = " "
      Readline.completion_proc = COMPARE
    end

    def self.start(path)
      new(path).start
    end

    def start
      while buffer = Readline.readline("> ", true)
        begin
          Code::Evaluator.eval(buffer,
            data_path: @data_path,
            history_path: @history_path
          )
        rescue ExecJS::ProgramError => error
          puts error.message
        end
      end
    end
  end
end
