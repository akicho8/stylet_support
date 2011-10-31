require File.expand_path(File.join(File.dirname(__FILE__), "tgm_mode"))

SegmentExtend = [
  [20.0, 0, 16, 22, 10, 28, 2],
]

class ExtendMController < Controller
  def initialize
    super
    init_level(SegmentExtend)
    @mode_name = "EXTEND-m"
    @life_count = 60*5
  end

  def game_over_start_signal(player)
    super
    player.field.cell_show_all
  end
end

module Modes
  class FrameExtendM < MementFrame
    Name = "EXTEND-m"
    def initialize
      @fields = [Field.create]
      @players = [
        Player.new(@fields[0], 4, Players::Player1.new, Pattern::HistoryRec.new, ExtendMController.new),
      ]
    end
  end
end

if $0 == __FILE__
  require "ui/sdl/input"
  require "ui/frame"
  frame = Modes::FrameExtendM.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
