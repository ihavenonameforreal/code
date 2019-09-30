require 'execjs'

class Code
  class Evaluator
    def initialize(text, data_path: nil, history_path: nil)
      @text = text
      @parsed = Code::Parser.parse(text)

      @data_path = data_path
      @data = Code::Object.new

      if @data_path && File.exists?(@data_path)
        @data = Code::Data.load(File.read(@data_path))
      end

      @history_path = history_path
      @history = []

      if @history_path && File.exists?(@history_path)
        @history = Code::Data.load(File.read(@history_path))
      end

      @definitions = Code::Object.new
      @values = Code::Object.new
    end

    def self.eval(text, data_path: nil, history_path: nil)
      new(text, data_path: data_path, history_path: history_path).eval_
    end

    def save
      if @history_path
        File.write(@history_path, Code::Data.dump(@history))
      end

      if @data_path
        File.write(@data_path, Code::Data.dump(@data))
      end
    end

    def eval_
      @parsed.each.with_index do |line, index|
        @history << Code::Object[
          index: index, line: line, time: Time.now
        ]

        if line.verb == "define"
          @definitions[line.signature.name] = Code::Object[
            signature: line.signature,
            definition: line.definition,
            lambda: lambda do |parameters|
              if line.definition.language == "ruby"
                locals = ""
                parameters.each.with_index do |parameter, index|
                  name = line.signature.parameters[index].value
                  locals += "#{name} = #{parameter.value.value.inspect}\n"
                end

                eval(locals + line.definition.code)
              elsif line.definition.language == "code"
              else
                "#{line.definition.language} not supported"
              end
            end
          ]
        elsif @definitions.keys.include?(line.verb)
          definition = @definitions[line.verb]
          definition.lambda.call(line.parameters)
        else
          abort "#{line.verb} undefined"
        end
      end
    end
  end
end

