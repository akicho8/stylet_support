#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-
# 思考ルーチン

$LOAD_PATH << ".."

require "input"
require "play"

class ThinkBase < InputUnit
  attr_reader :target

  def initialize
    super
    @target = nil
    @state = State.new
  end

  def update(player)
    if @target
      unless player.current_mino
        if player.next_mino
          if @target.dir != player.next_mino.dir
            rotate_mino(player.next_mino)# IRS
          end
          mino_lrmove(player.next_mino) # 出現前横溜め
        end
      else
        if @target.dir != player.current_mino.dir
          if (@state.count & 1) == 0
            rotate_mino(player.current_mino) # 出現後回転
          end
        end
        mino_lrmove(player.current_mino) # 出現後、溜めたままで横移動
        if @target.dir == player.current_mino.dir && @target.pos.x == player.current_mino.pos.x
          mino_down(player)
        end
        @state.pass
      end
    end
  end

  def rotate_mino(mino)
    case mino.dir.get_turn_to(@target.dir)
    when Direction::TURN_LEFT
      @button.btA << true
    when Direction::TURN_RIGHT
      @button.btB << true
    end
  end

  def mino_lrmove(mino)
    sx = @target.pos.x - mino.pos.x
    if 0 < sx
      @axis.right << true
    elsif sx < 0
      @axis.left << true
    end
  end

  def mino_down(player)
    if player.current_mino.moveable?(Point::DOWN)
      if player.controller.immfall_enable
        @axis.up << true        # 上入れ即落下
      else
        @axis.down << true      # 下入れ落下
      end
    else
      @axis.down << true        # 接着
    end
  end

  def think_first(player)
    @target = nil
    if player.next_mino
      mino = player.next_mino.clone
      mino.field.reject_lines
      field_old = mino.field.clone

      puts "#{player.object_id}: any_puton_case" if $DEBUG
      data = []
      any_puton_case(mino){|blk| data << blk.clone.freeze}

      puts "#{player.object_id}: compute_score" if $DEBUG
      data1 = data.collect{|blk|[blk,compute_score(field_old, blk)]}
      data2 = data1.sort{|a,b| a[1] <=> b[1]}
      @target = data2.last[0]
      puts "#{player.object_id}: done" if $DEBUG
      @state.transition(nil)
    end
  end

  def any_puton_case(mino)
    mino.each_dir {|dir|
      mino.dir.set(dir)
      mino.set_start_pos
      mino.dash(Point::LEFT)
      loop {
        mino.fall
        mino.puton{|e|yield e}
        mino.dash(Point::UP)
        break unless mino.moveable?(Point::RIGHT)
        mino.move(Point::RIGHT)
      }
    }
  end

  private

  def compute_score(field, mino)
    0
  end

end

module Players
  class ThinkLevel1 < ThinkBase
    Name = "思考君1号"
    Tooltip = "初心者です。レベル100程度。遅い。"
    def compute_score(field, mino)
      damage = mino.field.damage - field.damage
      top = mino.field.get_top2 - field.get_top2
      lines = mino.field.complate_info.size
      damage*-1 + top*-0.1 + lines*2
    end
  end

  class ThinkLevel2 < ThinkBase
    Name = "思考君2号"
    Tooltip = "粘り強い。レベル400程度。遅い。"
    def compute_score(field, mino)
      damage = mino.field.damage - field.damage
      top = mino.field.get_top2 - field.get_top2
      lines = mino.field.complate_info.size
      score = 0

      # 中央の隙間を減らすことは良いことだ。
      mino.field.width.times{|x|
        damage = field.damage(x) - mino.field.damage(x)
        score += damage * [1,2,3,4,5,4,3,2,1,0][x].to_i * 10.0
      }

      # 左側を高くすることは良いことだ。
      mino.field.width.times{|x|
        top2 = mino.field.get_top2(x) - field.get_top2(x)
        score += top2 * [5,4.5,4,5.1,4,4,3,2,1,0][x].to_i * 1.0
      }

      if mino.field.get_top2 < 10
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

  class ThinkLevel3 < ThinkLevel2
    Name = "思考君3号"
    Tooltip = "粘り強い。レベル400程度"
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

#       if mino.field.get_top2 >= 10
#         # 消すかどうかに関わらず、穴が埋まるのは良いことだ。→ 余計にアホになった。
#         mino.field.width.times{|x|
#           if field.hole?(x)
#             up = field.roughness2(x) - mino.field.roughness2(x) # up = 埋まった数
#             score += up * [5,4,3,2,1,1,2,3,4,5][x] * 5.0
#           end
#         }
#       end

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
        Player.new(@fields[0], 4,  Players::ThinkLevel2.new, obj.clone, ThinkController.new),
        Player.new(@fields[1], 4,  Players::ThinkLevel3.new, obj.clone, ThinkController.new),
      ]
    end
  end

  frame = FrameThinkDebug.new
  UI::DrawAll.new(frame)
  frame.start(60)

end
