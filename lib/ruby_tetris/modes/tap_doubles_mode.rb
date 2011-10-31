require File.expand_path(File.join(File.dirname(__FILE__), "tap_master_mode"))

class DoublesController < Controller
  def initialize
    super
    init_level(SegmentMaster)
    @mode_name = "DOUBLES"
  end
end

module Modes
  class FrameDoubles < MementFrame
    Name = "2P DOUBLES"
    def initialize
      @fields = [Field.new([14, 20+Field::INVISIBLE_AREA])]
      controller = DoublesController.new
      @players = [
        Player.new(@fields[0], 4, Players::Player1.new, Pattern::HistoryRec.new, controller),
        Player.new(@fields[0], 9, Players::Player2.new, Pattern::HistoryRec.new, controller),
      ]
    end
  end
end

if $0 == __FILE__
  require "ui/sdl/input"
  require "ui/frame"
  frame = Modes::FrameDoubles.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
