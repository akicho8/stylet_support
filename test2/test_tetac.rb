#!/usr/local/bin/ruby -Ku

require "test/unit"

class TestTetac < Test::Unit::TestCase
  def test_basic
    puts `../tetac.rb -w8 rr`
    puts `../tetac.rb -w8 -a rr`
    puts `../tetac.rb -w8 -a -g rr`
    puts `../tetac.rb -w8 -a -s rr`
    puts `../tetac.rb -w8 -a -c rr`
  end
end
