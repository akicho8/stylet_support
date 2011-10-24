#!/usr/local/bin/ruby -Ku


require "test/unit"

$LOAD_PATH << ".."
require "tool"

class TestTool < Test::Unit::TestCase
  def test_basic
    assert_equal(false, Tool.command_exist?("~"))
    assert_equal(true, Tool.command_exist?("ls"))
    assert_equal(true, Tool.possible_mpeg_play?)
    assert_equal(true, Tool.possible_mpeg_convert?)
    assert_equal(true, Tool.gnuplot_useful?)
  end
end
