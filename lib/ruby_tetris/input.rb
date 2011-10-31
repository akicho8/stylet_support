# -*- coding: utf-8 -*-
# キー入力関係

require File.expand_path(File.join(File.dirname(__FILE__), "input_utils"))
require File.expand_path(File.join(File.dirname(__FILE__), "key_one"))

# 構造体作成
Axis   = Struct.new(:up, :down, :left, :right)
Button = Struct.new(:btA, :btB, :btC, :btD)

# 上下左右とボタンのセット
class InputUnit
  attr_reader :axis, :button, :history

  def initialize
    @axis = Axis.new(KeyOne.new("u"), KeyOne.new("d"), KeyOne.new("l"), KeyOne.new("r"))
    @button = Button.new(KeyOne.new("AL"), KeyOne.new("BR"), KeyOne.new("C"), KeyOne.new("D"))
    @history = []
  end

  # ボタンの状態を配列で返す
  def get_button_array
    @button.values
  end

  # 上下左右とボタンの状態を配列で返す
  def key_objects
    @axis.values + @button.values
  end

  # レバーの更新前のビット状態を取得
  def state_to_s
    @axis.values.collect{|e|e.state_to_s}.to_s
  end

  # 適当に文字列化
  def to_s(stype=nil)
    case stype.to_s
    when "axis"   then @axis.values.to_s
    when "button" then @button.values.to_s
    else
      key_objects.to_s
    end
  end

  def next_frame(*args)
    update(*args)
    update_all
    @history << to_s
  end

  [
    :update,
    :think_first,       # 次のブロックへの操作が有効になった最初に呼ばれる
    :after_user_irs,    # IRSの後に呼ばれる
    :power_key_filled,  # 溜めができた時に呼ばれる
    :after_move,        # 移動後
  ].each do |method|
    define_method(method) do |*args, &block|
      p "#{self.class}##{method}" if $DEBUG
    end
  end

  # 左右の溜めが完了しているか?(次の状態から使えるか?)
  def key_power_effective?(power_delay)
    InputUtils.key_power_effective?(@axis.left, @axis.right, power_delay)
  end

  ########################################
  private
  # キーの状態を更新する。
  # ただし、上下が押されている時には左右を無効する。
  # これは斜め上を押しているときに横への溜めを禁止するため。
  def update_all
    if @axis.down.state || @axis.up.state
      @axis.left.state = @axis.right.state = false
    end
    key_objects.each{|e|e.update}
  end
end

require File.expand_path(File.join(File.dirname(__FILE__), "text_input_unit"))

module Players
  class Player1 < InputUnit
    include ReactionSuppressionModule
    Name = "DEBUG-1P"
    Tooltip = "キーボード配置1・ジョイスティック1"
  end

  class Player2 < InputUnit
    include ReactionSuppressionModule
    Name = "DEBUG-2P"
    Tooltip = "キーボード配置2・ジョイスティック2"
  end

  ################################################################################
  # 1Pと2Pを交互に使用する
  ################################################################################

  require "delegate"

  # ここは history を一つにするために Player1 は履歴対応してはいけない。
  # だから RecordHistory モジュールは必要だったのだ。でも大丈夫かも？
  # SimpleDelegator はインスタンス変数 @obj を持っているので衝突させないように注意。
  class Player12 < SimpleDelegator
    Name = "DEBUG-1P2P"
    Tooltip = "１人用のモードでツモ毎に操作を「DEBUG-1P」と「DEBUG-2P」で切り替える"
    def initialize
      @objs = [Player1.new, Player2.new]
      @pos = 0
      super(@objs[@pos])
    end
    def swap
      @pos = @pos.succ.modulo(@objs.size)
      __setobj__(@objs[@pos])
    end

    # SimpleDelegator の中で marshal_dump/load が定義されているので再び定義しないと
    # ここのインスタンスが保存されない。
    def marshal_dump
      [@objs, @pos]
    end
    def marshal_load(obj)
      @objs, @pos = obj
      __setobj__(@objs[@pos])
    end


#     def _dump(arg)
#       Marshal.dump([@objs, @pos])
#     end
#     def self._load(str)
#       @objs, @pos = Marshal.load(str)
#       __setobj__(@objs[@pos])
#     end
  end

end



if $0 == __FILE__

  x = Players::Player12.new
  a = Marshal.dump(x)
  b = Marshal.load(a)
  p b


#   str = <<-EOT
#   r* r r r d
#   .* r d
#   EOT
#   p TextInputUnit.new(str)


#   x = Players::Player12.new
#   x.update
#   x.swap

#   input = ["R","R","R","R"," "," ","L","L"," "," ","R","R","R"]
#   x = RSTextInputUnit.new(input)
#   input.each{
#     x.next_frame
#     x.instance_eval{
#       p x.rs
#     }
#   }
#   p x.history

end
