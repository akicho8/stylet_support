#!/usr/local/bin/ruby -Ku


require "test/unit"

$LOAD_PATH << ".."
require "play"
require "pattern"
require "ui/frame"

require "input_base"

class ThinkController < BaseController
  def initialize(speed=nil)
    super()
    @level_info = LevelInfo.new(speed || 1.0, 0.01, 26, 49, 15, nil, 3)
    @mode_name = "THINK DEBUG"
    @start_delay = 1
    @end_delay = 1
    @puton_count = 0
  end
  def signal_after_puton_signal(*args)
    @puton_count += 1
    if @puton_count == 2
      throw :exit
    end
  end
end

class FrameThinkDebug < Frame
  def initialize(inobj, pattern, speed, field="")
    @fields = [Field.create(field)]
    @players = [Player.new(@fields[0], 4, inobj, Pattern::OriginalRec.new(pattern), ThinkController.new(speed))]
  end
end

class TestInput2 < Test::Unit::TestCase

  def setup
  end

  def teardown
  end

  def start(input, pattern, speed, field="", ntimes=nil)
    frame = FrameThinkDebug.new(input, pattern, speed, field)
    UI::DrawFrame.new(frame)
    if ntimes
      ntimes.times{
        catch(:exit){
          frame.next_frame
        }
      }
    else
      frame.start
    end
    pl = frame.players.first
    pl.puton
    pl.field
  end

  def test_irs
    field = <<END
ggggg gggg
ggggg gggg
ggggg gggg
ggggg gggg
END
    assert_equal(<<END, start(input=Players::ThinkLevel1.new, "r", 20.0, field, 2).to_s(:ustrip => true))
gggggrgggg
gggggrgggg
gggggrgggg
gggggrgggg
END
  end

  def test_minos
    start(input=Players::ThinkLevel1.new, "ybogmcr"*10, 0.0).to_s(:ustrip => true)
  end

  def test_case1
    field = <<END
ggggg gggg
END
    start(input=Players::ThinkLevel1.new, "bobo", 0.0, field).to_s(:ustrip => true)
  end

end
