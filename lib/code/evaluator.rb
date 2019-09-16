require 'execjs'

class Code
  class Evaluator
    def initialize(text, data_path: nil, history_path: nil)
      @text = text
      @parsed = Code::Parser.parse(text)

      @data_path = data_path
      @data = {}

      if @data_path && File.exists?(@data_path)
        @data = Code::Data.load(File.read(@data_path))
      end

      @history_path = history_path
      @history = []

      if @history_path && File.exists?(@history_path)
        @history = Code::Data.load(File.read(@history_path))
      end
    end

    def self.eval(text, data_path: nil, history_path: nil)
      new(text, data_path: data_path, history_path: history_path).eval
    end

    def save
      if @history_path
        File.write(@history_path, Code::Data.dump(@history))
      end

      if @data_path
        File.write(@data_path, Code::Data.dump(@data))
      end
    end

    def eval
      @parsed.each.with_index do |line, index|
        @history << { line: line, time: Time.now, index: index }

        verb = line["verb"]

        if verb == "give"
          to = (line["to"] || [""]).join(" ")
          from = (line["from"] || [""]).join(" ")
          @data[to] ||= 0
          @data[to] += line["quantity"].to_i
          @data[from] ||= 0
          @data[from] -= line["quantity"].to_i
          save
        elsif verb == "reset"
          @data = {}
          @history = []
          save
        elsif verb == "history"
          puts Code::Data.dump(@history)
          save
        elsif verb == "show"
          puts Code::Data.dump(@data)
        elsif verb == "help"
          puts <<~HELP
            afficher
            aide
            donner QUANTITÉE (à PERSONNE) (de la part de PERSONNE) (pour RAISON)
            historique
            quitter
            recommencer
          HELP
        elsif verb == "exit"
          exit
        else
          abort "#{verb} not supported"
        end
      end
    end
  end
end

