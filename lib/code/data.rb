#!/usr/bin/env ruby

require 'json'

class Code
  class Data
    def self.load(text)
      Code::Object[JSON.parse(text)]
    end

    def self.dump(text)
      JSON.pretty_generate(text)
    end
  end
end
