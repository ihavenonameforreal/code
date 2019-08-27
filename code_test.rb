require_relative "lib/code.rb"
require "test/unit"

class TestCode < Test::Unit::TestCase
  def test_for_smoke
    Code.parse("donner 1 a dorian")
    Code.eval("donner 1 a dorian")
  end
end

