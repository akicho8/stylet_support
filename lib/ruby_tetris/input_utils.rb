# ボタン同士の優先順位を得るユーティリティ

module InputUtils
  module_function

  # 2つのキーの優先順位を得る
  #
  # a = KeyOne.new
  # b = KeyOne.new
  #
  # 1フレーム目。aだけ押されたのでaが返る
  # a.update(true)
  # b.update(false)
  # InputUtils.preference_key(a, b) #=> a
  #
  # 2フレーム目。aは押しっぱなしだが、bの方が若いのでbが返る
  # a.update(true)
  # b.update(true)
  # InputUtils.preference_key(a, b) #=> b
  #
  def preference_key(lhs, rhs, default_key = lhs)
    case
    when rhs.press? && lhs.press?
      case
      when rhs.count < lhs.count; rhs
      when lhs.count < rhs.count; lhs
      else
	default_key
      end
    when rhs.press?; rhs
    when lhs.press?; lhs
    else
      nil
    end
  end

  # 2つのキーのどちらかの溜め完了しているか？(次の状態から使えるか？)
  #
  #      1 2 3 4 5 6 frame
  # lhs  0 0 0 0 0 0
  # rhs  1 0 0 2 3 4
  #
  # 3フレーム目で key_power_effective?(lhs, rhs, 2) #=> true になる
  #
  def key_power_effective?(lhs, rhs, power_delay)
    if key = InputUtils.preference_key(lhs, rhs)
      key.repeat(power_delay - 1) > 1
    end
  end
end
