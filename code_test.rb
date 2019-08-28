require_relative "lib/code.rb"
require "test/unit"

class TestCode < Test::Unit::TestCase
  def test_for_smoke
    Code.eval("donner 1 a dorian")
  end

  def test_for_file_smoke
    Code.eval(File.read('samples/donner.code'))
  end
end
