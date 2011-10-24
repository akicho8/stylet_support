#!/usr/local/bin/ruby -Ku
# 思考ルーチン


$LOAD_PATH << ".."

require "input_base"
require "play"

PosDir = Struct.new("PosDir", :pos, :dir)

class ThinkBase2 < ThinkBase
  attr_reader :target

  def think_first(player)
    @target = nil
    if player.next_mino
      mino = player.next_mino.clone
      mino.field.reject_lines
      field_old = mino.field.clone

      puts "#{player.object_id}: any_puton_case" if $DEBUG
      data = []
      any_puton_case(mino){|blk| data << [blk.pos_info, compute_score(field_old, blk)]}

      puts "#{player.object_id}: compute_score" if $DEBUG
      data2 = data.sort{|a,b| a[1] <=> b[1]}
      @target = PosDir.new(*data2.last[0])
      puts "#{player.object_id}: done" if $DEBUG
      @state.transition(nil)
    end
  end

end

module Players
  class ThinkLevel4 < ThinkBase2
    Name = "思考君4号"
    Tooltip = "粘り強い。レベル400程度。やや速い。"
    def compute_score(field, mino)

      damage = mino.field.damage - field.damage
      top = mino.field.get_top2 - field.get_top2
      lines = mino.field.complate_info.size
      score = 0

      # 中央の隙間を減らすことは良いことだ。
      mino.field.width.times{|x|
        damage = field.damage(x) - mino.field.damage(x)
        score += damage * [2.6,2.8,3,4,5,4,3,2,1,0][x].to_i * 10.0
      }

      # 左側を高くすることは良いことだ。
      mino.field.width.times{|x|
        top2 = mino.field.get_top2(x) - field.get_top2(x)
        score += top2 * [5.8,4.5,4,5.1,4,4,3,2,1,0][x].to_i * 1.0
      }

      if mino.field.get_top2 < 12
        # 低い時
        score += top * -10.0           # 高く詰むいことは少し悪いことだ。
        score += lines * [0,1,5,10,15][lines] # 1ライン消しはあまりよくない
      else
        # 高い時
        score += top * -15.0           # 高く詰むいことはとても悪いことだ。
        score += lines * [0,15,25,30,35][lines] # 消すことは重要だ。
      end

      score

    end
  end

end

if $0 == __FILE__

  require "config"
  require "pattern"
  require "gui_tgm"
# #   require "../modes/tgm_mode.rb"
   p $LOAD_PATH
  require "tap_master_mode"

  class ThinkController < TGMController
    def initialize(speed=nil)
      super()
      # @level_info = LevelInfo.new(speed || 0.0, 0.01, 26, 49, 15, nil, 3)
      @mode_name = "THINK DEBUG"
      @start_delay = 1
    end
#     def signal_after_puton_signal(*args)
#       # throw :exit
#     end
  end

  class FrameThinkDebug < Frame
    def initialize
      @fields = [
        Field.create,
        Field.create,
      ]
      obj = Pattern::HistoryRec.new
      @players = [
        Player.new(@fields[0], 4,  Players::ThinkLevel4.new, obj.clone, ThinkController.new),
        Player.new(@fields[1], 4,  Players::ThinkLevel4.new, obj.clone, ThinkController.new),
      ]
    end
  end

  frame = FrameThinkDebug.new
  UI::DrawAll.new(frame)
  frame.start(60)

end
