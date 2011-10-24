#!/usr/local/bin/ruby -Ku

$LOAD_PATH << ".." if $0 == __FILE__

require "tgm_mode"

require "config"
require "tgm_debug_mode"

module VersusControllerMethods
  attr_accessor :target_player, :field_before_puton

  def initialize
    super
    @target_player = nil
    @field_before_puton = nil
  end

  # 置いたときに消える場合は、置く前の状態のコピーを取る
  def before_puton_signal(player)
    if player.current_mino.attempt_complate_lines >= 1
      @field_before_puton = player.field.clone
    end
  end

  # 新しい状態の消した行を見て、古い方のフィールドからその行を取り出す。
  def lines_clear_signal(player)
    super
    return if player.field.complate_info.size < send_mino_line_limit
    player.field.complate_info.reverse_each{|y|
      @target_player.controller.updata << player.controller.field_before_puton.xarray(y)
    }
  end

  # この値未満は相手に送らない
  def send_mino_line_limit
    2
  end
end

class VersusController < MasterController
  include VersusControllerMethods
  def initialize
    super
    @mode_name = "MASTER VS"
  end
end

module Modes
  class FrameVersus < MementFrame
    Name = "2P MASTER VS"
    def initialize
      @fields = [
        Field.create,
        Field.create,
      ]
      @players = [
        Player.new(@fields[0], 4, Players::Player1.new, Pattern::HistoryRec.new, VersusController.new),
        Player.new(@fields[1], 4, Players::Player2.new, Pattern::HistoryRec.new, VersusController.new),
      ]
      @players[0].controller.target_player = @players[1]
      @players[1].controller.target_player = @players[0]
    end
  end
end

if $0 == __FILE__
  require "ui/sdl/input"
  require "ui/frame"
  frame = Modes::FrameVersus.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
