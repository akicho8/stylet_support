#!/usr/local/bin/ruby -Ku

$LOAD_PATH << ".." if $0 == __FILE__

require "play"
require "score"
require "input"
require "pattern"

class TDSBaseController < BaseController
end

class TDSController < TDSBaseController
  def initialize
    super
    @mode_name = "TETRIS DS"
    @immfall_enable = true
    @level_info = LevelInfo.new(0.01, 0.0, 0, 0, 15, nil, 3)
  end
end

module Modes
  class FrameTDS < Frame
    Name = "TDS"
    def initialize
      @fields = [Field.create]
      @players = [Player.new(@fields[0], 4,  Players::Player1.new, Pattern::HistoryRec.new, TDSController.new, Mino::World)]
    end
  end
end

if $0 == __FILE__
  require "ui/sdl/input"
  require "ui/frame"
  frame = Modes::FrameTDS.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
