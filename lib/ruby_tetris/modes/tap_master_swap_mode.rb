require File.expand_path(File.join(File.dirname(__FILE__), "tap_master_mode"))

class MasterSwapController < MasterController
  include SwapController
  def initialize
    super
    @mode_name = "MASTER-SWAP"
  end
end

module Modes
  class FrameMasterSwap < MementFrame
    Name = "2P MASTER SWAP"
    def initialize
      @fields = [Field.create]
      @players = [Player.new(@fields[0], 4,  Players::Player12.new, Pattern::HistoryRec.new, MasterSwapController.new)]
    end
  end
end

if $0 == __FILE__
  require "ui/sdl/input"
  require "ui/frame"
  frame = Modes::FrameMasterSwap.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
