require "test_helper"

class TestVector < Test::Unit::TestCase
  setup do
    @p0 = Vector.new(10, 20)
    @p1 = Vector.new(100, 200)
    @obj = Vector.new(3, 4)
  end

  test "ランダム" do
    Vector.rand
  end

  sub_test_case "加減演算" do
    test "加減算" do
      assert { (@obj + @obj) == Vector.new(6, 8) }
      assert { (@obj - @obj) ==  Vector.zero }
    end

    test "右辺は配列でも可" do
      assert { (@obj + [3, 4]) == Vector.new(6, 8) }
      assert { (@obj - [3, 4]) == Vector.zero }
    end
  end

  test "スケーリング" do
    assert { @obj.scale(2) == Vector.new(6, 8) }
    assert { (@obj * 2) == Vector.new(6, 8) }
    assert { (@obj * 0.5) == Vector.new(1.5, 2.0) }
  end

  test "正規化" do
    assert { Vector.new(3, 4).normalize == Vector.new(0.6, 0.8) }
  end

  sub_test_case "破壊的メソッド" do
    test "add!" do
      @p0.add!(@p1)
      assert { @p0 == Vector.new(110, 220) }
    end

    test "sub!" do
      @p0.sub!(@p1)
      assert { @p0 == Vector.new(-90, -180) }
    end

    test "scale!" do
      @p0.scale!(2)
      assert { @p0 == Vector.new(20, 40) }
    end

    test "normalize!" do
      @p0.normalize!
      @p0
    end
  end

  test "長さ" do
    assert { Vector.new(3, 4).magnitude == 5 }
  end

  test "距離" do
    assert { @p0.distance_to(@p1).to_i == 201 }
  end

  test "方向" do
    assert { @p0.angle_to(@p1) < 1.0 }
  end
end
