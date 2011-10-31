# -*- coding: utf-8 -*-

require File.expand_path(File.join(File.dirname(__FILE__), "../core"))

SegmentTGM = [
  [1.0/128,    1.0/1024, 26, 49, 15, 36,  3],
  [ 1.0/32,     1.0/256, 26, 49, 15, 36,  3],
  [ 1.0/64,     1.0/128, 26, 49, 15, 36,  3],
  [    1.0,     4.0/100, 26, 49, 15, 36,  3],
  [    5.0,           0, 26, 49, 15, 36,  3],
  [    5.0,     -1.0/50, 26, 49, 15, 36,  3],
  [     20,           0, 26, 49, 15, 36,  3],
  [     20,           0, 26, 49, 15, 36,  3],
  [     20,           0, 26, 49, 15, 36,  3],
  [     20,           0, 26, 49, 15, 36,  3],
]

# スコア関連イベント
module ScoreController
  GradeTable = [
    [     0,  "9"],
    [   400,  "8"],
    [   800,  "7"],
    [  1400,  "6"],
    [  2000,  "5"],
    [  3500,  "4"],
    [  5500,  "3"],
    [  8000,  "2"],
    [ 12000,  "1"],
    [ 16000, "S1"],
    [ 22000, "S2"],
    [ 30000, "S3"],
    [ 40000, "S4"],
    [ 52000, "S5"],
    [ 66000, "S6"],
    [ 82000, "S7"],
    [100000, "S8"],
    [120000, "S9"],
  ]

  attr_reader :score_count

  def initialize
    super
    @score_count = 0
    @score = Score.new
    @grade_count = 0
  end

  # ブロックがセットされた時
  def mino_set_signal(*args)
    super
    @up_cells = 0
    @down_cells = 0
    @set_by_down = 0
  end

  # ユーザーにより上が押されてブロックを即落下させてるときに毎回呼ばれる
  def immediate_fall_signal
    @up_cells += 1
  end

  # ユーザーにより下が押されてブロックを即落下させてるときに毎回呼ばれる
  def mino_down
    @set_by_down += 1
  end

  # 意図的に接着された
  def intent_lock_signal(*args)
    super
    @set_by_down = 1
  end

  # 置いたけどラインクリアしなかった時
  def non_line_clear_signal
    super
    @score.reset
  end

  def grade_name
    v = GradeTable[@grade_count]
    return "Gm" unless v
    score, name = v
    name
  end

  def lines_clear_signal(player)
    super

    # level_count:      lv 消す前のレベル
    # line_count:       n 消したライン数
    # up_cells:         u レバー上で落下させた段数
    # down_cells:       d1 レバー下で落下させた段数
    # set_by_down:      d2 接地状態からレバー下で接着させれば 1、なければ 0
    #
    # m_line_c:         C コンボ開始から直前の消しまでの全ての消しについて、(2n-2)を累積して加算した値

    line_count = player.field.complate_info.size
    @score_count += @score.compute(@level_count, line_count, @up_cells, @down_cells, @set_by_down)
    loop {
      break unless GradeTable[@grade_count.succ]
      next_score, next_grade_name = GradeTable[@grade_count.succ]
      break if @score_count < next_score
      @grade_count += 1
      grade_up_signal(self)
    }
  end

  private
  # なし
end

# レベルに関する処理
module LevelController
  attr_reader :level_count, :segment_level, :level_interval

  def initialize
    super
    @segment = nil
    @segment_level = 0
    @level_count = 0
    @delete_mino_table = []
  end

  # 移動可能になった最初の状態でレベルは上る
  def move_before_signal(*args)
    return if level_count_stop?
    level_count_up
  end

  # ライン消しした時に呼ばれる。
  def lines_clear_signal(player)
    super
    # レベルを足している間にカンストで終了してしまったらスコアが足されないのでこれは最後に呼ぶ。
    line_count = player.field.complate_info.size
    @delete_mino_table[@segment_level] ||= []
    @delete_mino_table[@segment_level] << line_count
    line_count.times{level_count_up}
  end

  # レベルの最大を得る
  def level_max
    @segment.size * @level_interval - 1
  end

  ########################################
  private

  def init_level(segment, level_interval=100)
    @segment = segment
    @level_info = LevelInfo.new(*@segment[@segment_level])
    @level_interval = level_interval
  end

  # 次のセグメントの開始レベルを返す(現在0-99なら100を得る)
  def next_level
    (@level_count + @level_interval) / @level_interval * @level_interval
  end

  # レベルストップしてしまうレベル値を返す
  def next_level_stop
    if @segment[@segment_level.succ]
      next_level - 1
    else
      next_level - 2
    end
  end

  # レベルを一つ上げる
  def level_count_up
    @level_info.speed += @level_info.acceleration
    if @level_count.succ == next_level
      if @segment[@segment_level.succ]
        @segment_level += 1
        @level_info = LevelInfo.new(*@segment[@segment_level])
        signal_section_up(self) if respond_to?(:signal_section_up)
      end
    end
    level_count_increment_signal(self)
    if level_count_last?
      throw :exit, :clear
    end
  end

  # レベルを+1する(フックできるようにメソッド化)
  def level_count_increment_signal(*args)
    super
    @level_count += 1
  end

  # レベルカンスト?
  def level_count_last?
    @level_count == level_max
  end

  # レベルストップ
  def level_count_stop?
    @level_count == next_level_stop
  end
end

# タイムに関する処理
module TimeController
  FPS = 60                      # あくまで、カウンタを時間に変換するのに使う

  def initialize
    super
    @time_count = 0
    @active = false             # プレイ中か?(つまり時間をカウントしていいか?)
  end

  # 開始時に呼ばれる
  def start_signal(*args)
    super
    @active = true
  end

  # 毎回呼ばれる
  def pass(*args)
    super
    return unless @active
    active_pass
  end

  # プレイ中のみ呼ばれる
  def active_pass
    @time_count += 1
  end

  # カウンタから時間文字列に変換して返す(fps値を知る必要がある)
  def time_count
    count_to_timestr(@time_count, FPS)
  end

  def game_over_start_signal(player)
    super
    @active = false
  end

  private

  def count_to_timestr(count, fps=FPS)
    "%02d:%02d:%02d" % count_to_time(count, fps)
  end

  def count_to_time(count, fps=FPS)
    [count/(fps*60), (count/fps)%60, count%fps*100/fps]
  end
end

module LossTimeController
  def initialize
    super
    @loss_table = []
  end

  def active_pass
    super
    return unless level_count_stop?
    @loss_table[@segment_level] ||= 0
    @loss_table[@segment_level] += 1
  end
end

################################################################################

# 入力オブジェクトにswapメソッドがあれば交互に操作する
module SwapController
  def signal_after_puton_signal(player)
    super
    if player.input.respond_to?(:swap)
      player.input.swap
    end
  end
end

################################################################################

# 処理に関する部分。スコア・レベル・タイムをここで合流させる。
# このインスタンスはプレイヤーそれぞれに渡すこと。共有することはできない。

class Controller < BaseController
  include TimeController
  include LossTimeController
  include ScoreController
  include LevelController
  # include SwapController

  # これはデバッグ用？
  # require "with_sound"
  # include PassCountController
  include SoundController
end

class TGMController < Controller
  def initialize
    super
    init_level(SegmentTGM)
    @mode_name = "TGM"
    @immfall_enable = false
  end
end

require File.expand_path(File.join(File.dirname(__FILE__), "../with_sound"))

module Modes
  class FrameTGM < MementFrame
    Name = "TGM"
    def initialize
      @fields = [Field.create]
      @players = [Player.new(@fields[0], 4,  Players::Player1.new, Pattern::HistoryRec.new, TGMController.new)]
    end
  end
end

if $0 == __FILE__
  require "ui/sdl/input"
  require "ui/frame"
  frame = Modes::FrameTGM.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
