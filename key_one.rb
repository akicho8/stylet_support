# ボタン一つの情報を管理するクラス
# state をセットして update することでカウンタが更新される
class KeyOne
  attr_reader :mark, :count
  attr_accessor :state

  def initialize(mark = "?")
    @mark = mark.to_s.scan(/./) # "AR" だったら A と R に対応
    @count = 0
    @state = false              # 直近のフラグ
  end

  # 直近フラグを設定。falseにはできない。
  def <<(arg)
    case arg
    when String
      if false
        arg = arg.include?(@mark)
      else
        arg = !!@mark.find{|m|arg.include?(m)}
      end
    when Fixnum
      arg = (arg != 0)
    end
    @state |= arg
  end

  # 更新する前のon/off状態を取得
  def state_to_s
    @state ? mark.first : ""
  end

  # 引数が指定されていればそれを直近の状態をして設定して更新する。
  def update(state = nil)
    if state
      self << state
    end
    if @state
      @count += 1
    else
      @count = 0
    end
    @state = false
  end

  # キーリピート2としたときの挙動
  # 3フレーム目に押された場合
  #
  #        2 3 4 5 6 7 (frame)
  #  count 0 1 2 3 4 5
  # repeat 0 1 0 0 2 3
  #            ^ ^  の数(1と2の間がの数)がkey_repeat
  #
  def repeat(key_repeat = 12)
    repeat = 0
    if count == 1
      repeat = 1
    elsif count > key_repeat + 1
      repeat = count - key_repeat
    else
      repeat = 0
    end
    repeat
  end

  def free?
    @count == 0
  end

  def press?
    @count >= 1
  end

  def trigger?
    @count == 1
  end

  def <=>(other)                # sortで優先度の高い順に並べる為の比較処理
    if @count == 0 || other.count == 0
      other.count <=> @count    # 0はもっとも優先度が低い為逆にする
    else
      @count <=> other.count
    end
  end

  def ==(other)
    count == other.count
  end

  def to_s
    press? ? mark.first : ""
  end
end
