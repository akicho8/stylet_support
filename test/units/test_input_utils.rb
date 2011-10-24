$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/.."))
require "test_helper"

class TestInputUtils < Test::Unit::TestCase
  def setup
    @left = KeyOne.new
    @right = KeyOne.new
  end

  # 入力優先順位テスト
  def test_preference_key
    # 最初は両方押されていないので nil が返る。
    assert_nil preference_key

    # 左だけ押されると、もちろん左が優先される。
    @left.update(true)
    @right.update(false)
    assert_equal @left, preference_key

    # 次のフレーム。左は押しっぱなし。右を初めて押した。すると右が優先される。
    @left.update(true)
    @right.update(true)
    assert_equal @right, preference_key

    # 次のフレーム。両方離した。nil が返る。
    @left.update(false)
    @right.update(false)
    assert_nil preference_key

    # 次のフレーム。両方同時押し。左が優先される。
    @left.update(true)
    @right.update(true)
    assert_equal @left, preference_key
  end

  def test_key_power_effective?
    @left = KeyOne.new
    @right = KeyOne.new
    @right.update(true); assert_equal false, InputUtils.key_power_effective?(@left, @right, 2)
    @right.update(true); assert_equal false, InputUtils.key_power_effective?(@left, @right, 2)
    @right.update(true); assert_equal  true, InputUtils.key_power_effective?(@left, @right, 2)
  end

  private

  def preference_key
    InputUtils.preference_key(@left, @right)
  end
end
