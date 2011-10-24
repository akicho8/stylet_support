$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/.."))
require "test_helper"

class TestPattern < Test::Unit::TestCase
  def create_random_ary(size, count)
    x = Pattern::Random.new(0)
    ary = Array.new(size).fill(0)
    count.times {ary[x.get_next(size)] += 1}
    ary
  end

  def test_random
    ary = create_random_ary(10, 1000)
    assert(0 < ary.min)
    assert(0 < ary.max)
  end

  def create_pattern_ary(obj, count)
    ary = Array.new(Mino::Classic.list.size).fill(0)
    count.times {ary[obj.get_next] += 1}
    ary
  end

  def test_history_pattern      # バラツキのあるクラス用
    num = 300                   # ブロック１つ当たりの予想出現回数
    gap = 20                    # 出現回数の予想ばらつき
    ary = create_pattern_ary(Pattern::History.new(0), Mino::Classic.list.size*num)
    assert((num-gap) < ary.min && ary.max < (num+gap))
  end

  def same_rate_check(klass)    # 大きな間隔で出現率は一致するクラス用
    num = 100
    ary = create_pattern_ary(klass.new(0), Mino::Classic.list.size*num)
    assert_equal(num, ary.min)
    assert_equal(num, ary.max)
  end

  def test_shuffle_pattern
    same_rate_check(Pattern::Shuffle)
  end

  def test_original_pattern
    obj = Pattern::Original.new("bo")
    ary = []
    4.times {ary << obj.get_next}
    assert_equal(["b","o",nil,nil], ary)
  end

  # 履歴機能テスト
  def test_original_pattern_rec
    x = Pattern::OriginalRec.new("bo")
    3.times{x.get_next2}
    assert_equal(["b","o",nil], x.history)
  end

  # 最初のブロックは黄緑紫がでないか?
  def test_get_next2
    hash = Hash.new(0)
    300.times{
      hash[Pattern::History.new.get_next2] += 1
      hash[Pattern::Shuffle.new.get_next2] += 1
    }
    assert_equal(4, hash.size)  # 4種類に限定されるはず
  end
end
