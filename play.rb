#!/usr/local/bin/ruby -Ku
# テトリスの基本なゲームの流れ (ConcreteSubject)


require "tetris"
require "observer"
require "yaml"
require "state"
require "mino_base"

=begin

パラメータの意味

  speed        - 落下速度
  acceleration    - 加速度
  next_delay   - 次のブロックが移動可能になるまで
  fall_delay   - 浮いたブロックが落るまで
  next_delay2  - 次のブロックが移動可能になるまで(消したとき)
  lock_delay   - 接着時間
  flash_delay  - 白く光る時間

適用順

  lock_delay --> flash_delay --> next_delay
                             --> fall_delay --> next_delay2
=end

LevelInfo = Struct.new("LevelInfo", :speed, :acceleration, :next_delay, :fall_delay, :next_delay2, :lock_delay, :flash_delay)

class BaseController
  include Observable # For SoundController

  attr_accessor :level_info
  attr_reader :mode_name, :life_count, :start_delay, :end_delay, :updata, :power_delay, :up_put, :down_put
  attr_reader :immfall_enable, :irs_enable

  def initialize
    @level_info = LevelInfo.new(0.1, 0.01, 26, 49, 15, 36, 3)
    @mode_name = "Unknown"
    @life_count = nil           # nil=セルの命は無限
    @start_delay = 60
    @end_delay = 60*2
    @base_speed = 0.0
    @immfall_enable = true      # 上入れ即落下有効？
    @irs_enable = true          # IRS有効？
    @up_put = false             # 上を押して固定できるか？
    @down_put = true            # ブロックが設置しているときに下を入れて固定できるか？
    @updata = []
    @power_delay = 12           # 横溜め時間
  end

  def speed
    @base_speed + @level_info.speed
  end

  ################################################################################
  # シグナル系
  ################################################################################

  # def method_missing(sym, *args)
  #   p "#{self.class}#method_missing: #{sym}"
  # end

  [
    :pass,
    :ready_go_signal,
    :start_signal,
    :mino_set_signal,
    :level_count_increment_signal,
    :collision_signal,
    :fall_collision_signal,
    :max_velocity_fall_collision_signal,
    :mino_down,
    :auto_lock_signal,
    :lock_signal,
    :before_puton_signal,
    :signal_after_puton_signal,
    :non_line_clear_signal,
    :lines_reject_after_signal,
    :right_left_move_after_signal,
    :rotate_after_signal,
    :user_irs_success_signal,
    :block_up_call_signal,
    :game_over_start_signal,
    :lines_clear_signal,
    :signal_field_down_signal,
    :intent_lock_signal,
    :irs_signal, # 未使用。不要。他のとだぶっている。IRSが成功してなくても呼ばれる可能性あり
    :move_before_signal,
    :grade_up_signal,
    :immediate_fall_signal,
  ].each do |method|
    define_method(method) do |*args, &block|
      if $DEBUG
        p "Signal: #{self.class}##{method}"
      end

      # if method.to_s.match(/collision/)
      #   p "Signal: #{self.class}##{method}"
      # end
    end
  end
end

# class BaseDSController < BaseController
#   def initialize(*)
#     super
#     @up_put = true              # 上を押して固定できる
#     @down_put = false           # ブロックが設置しているときに下を入れて固定できない
#   end
# end

require "player"
require "frame"

=begin

テキスト画面への出力をする場合、以下のクラスを元にする

class TextDisplay
  def initialize(frame)
    @frame = frame
    frame.add_observer(self)
  end
  def update(frame)
  end
end

=end

if $0 == __FILE__

  require "input"
  require "pattern"
  class FrameSimple < Frame
    def initialize
      @fields = [Field.new([10, 22])]
      @players = [Player.new(@field, 4, TextInputUnit.new(["U"]*(60*3)), Pattern::HistoryRec.new, BaseController.new)]
    end
  end

  x = FrameSimple.new
  p x.start                     # result = :lost_key
  puts x.field.to_s(:ustrip => true)

end
