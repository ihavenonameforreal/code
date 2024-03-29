require 'mini_racer'
require 'execjs'

class Code
  class Parser
    PARSER_JS_PATH = File.expand_path('../parser.js', __FILE__)
    PARSER_JS = File.read(PARSER_JS_PATH)

    def initialize(text)
      @text = text
      @compiled = ExecJS.compile(PARSER_JS)
    end

    def self.parse(text)
      new(text).parse
    end

    def parse
      @compiled.call("Parser.parse", @text).map do |line|
        Code::Object[line]
      end
    end
  end
end
