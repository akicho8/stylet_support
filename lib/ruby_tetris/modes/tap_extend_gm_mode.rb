require File.expand_path(File.join(File.dirname(__FILE__), "tap_extend_m_mode"))

class ExtendGMController < ExtendMController
  def initialize
    super
    @mode_name = "EXTEND-GM"
    @life_count = 0
  end
end

module Modes
  class FrameExtendGM < MementFrame
    Name = "EXTEND-Gm"
    def initialize
      @fields = [Field.create]
      @players = [
        Player.new(@fields[0], 4, Players::Player1.new, Pattern::HistoryRec.new, ExtendGMController.new),
      ]
    end
  end
end

if $0 == __FILE__
  require "ui/sdl/input"
  require "ui/frame"
  frame = Modes::FrameExtendGM.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
