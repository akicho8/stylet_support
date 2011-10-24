#!/usr/local/bin/ruby -Ku


$LOAD_PATH << ".." if $0 == __FILE__

require "tgm_mode"

SegmentDeath = [
  [20.0, 0, 16, 22, 10, 28, 2],
  [20.0, 0, 15, 20,  9, 26, 2],
  [20.0, 0, 14, 18,  8, 24, 2],
  [20.0, 0, 13, 16,  7, 22, 2],
  [20.0, 0, 12, 14,  6, 20, 2],
  [20.0, 0,  8,  0,  8, 16, 1],
  [20.0, 0,  7,  0,  7, 14, 1],
  [20.0, 0,  6,  0,  6, 12, 1],
  [20.0, 0,  5,  0,  5, 10, 1],
  [20.0, 0,  4,  0,  4,  8, 1],
]

class DeathController < Controller
  def initialize
    super
    init_level(SegmentDeath)
    @mode_name = "DEATH"
  end
end

module Modes
  class FrameDeath < MementFrame
    Name = "DEATH"
    def initialize
      @fields = [Field.create]
      @players = [Player.new(@fields[0], 4,  Players::Player1.new, Pattern::HistoryRec.new, DeathController.new)]
    end
  end
end

if $0 == __FILE__
  require "ui/sdl/input"
  require "ui/frame"
  frame = Modes::FrameDeath.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
