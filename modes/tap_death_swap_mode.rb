#!/usr/local/bin/ruby -Ku

$LOAD_PATH << ".." if $0 == __FILE__

require "tap_death_mode"

class DeathSwapController < DeathController
  include SwapController
  def initialize
    super
    @mode_name = "DEATH-SWAP"
  end
end

module Modes
  class FrameDeathSwap < MementFrame
    Name = "2P DEATH SWAP"
    def initialize
      @fields = [Field.create]
      @players = [Player.new(@fields[0], 4,  Players::Player12.new, Pattern::HistoryRec.new, DeathSwapController.new)]
    end
  end
end

if $0 == __FILE__
  require "ui/sdl/input"
  require "ui/frame"
  frame = Modes::FrameDeathSwap.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
