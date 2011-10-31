require File.expand_path(File.join(File.dirname(__FILE__), "tgm_mode"))
require File.expand_path(File.join(File.dirname(__FILE__), "tap_master_mode"))

SegmentMasterDebug = [
  [1.0/128, 1.0/1024, 22, 32, 12, 36, 3],
  [1.0/32,  1.0/256,  22, 32, 12, 36, 3],
]

class MasterDebugController < MasterController
  def initialize
    super
    init_level(SegmentMasterDebug, 10)
    @mode_name = "MASTER Debug"
  end
end

module Modes
  class FrameMasterDebug < MementFrame
    Name = "MASTER Debug"
    def initialize
      @fields = [Field.create]
      @players = [Player.new(@fields[0], 4,  Players::Player1.new, Pattern::HistoryRec.new, MasterDebugController.new)]
    end
  end
end

if $0 == __FILE__
  require "ui/sdl/input"
  require "ui/frame"
  frame = Modes::FrameMasterDebug.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
