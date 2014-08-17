# -*- coding: utf-8 -*-
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
      assert_equal Vector.new(6, 8), (@obj + @obj)
      assert_equal Vector.zero, (@obj - @obj)
    end

    test "右辺は配列でも可" do
      assert_equal Vector.new(6, 8), (@obj + [3, 4])
      assert_equal Vector.zero, (@obj - [3, 4])
    end
  end

  test "スケーリング" do
    assert_equal Vector.new(6, 8), @obj.scale(2)
    assert_equal Vector.new(6, 8), (@obj * 2)
    assert_equal Vector.new(1.5, 2.0), (@obj * 0.5)
  end

  test "正規化" do
    assert_equal Vector.new(0.6, 0.8), Vector.new(3, 4).normalize
  end

  sub_test_case "破壊的メソッド" do
    test "add!" do
      @p0.add!(@p1)
      assert_equal Vector.new(110, 220), @p0
    end
    test "sub!" do
      @p0.sub!(@p1)
      assert_equal Vector.new(-90, -180), @p0
    end
    test "scale!" do
      @p0.scale!(2)
      assert_equal Vector.new(20, 40), @p0
    end
    test "normalize!" do
      @p0.normalize!
      @p0
    end
  end

  test "長さ" do
    assert_equal 5, Vector.new(3, 4).magnitude
  end

  test "距離" do
    assert_equal 201, @p0.distance_to(@p1).to_i
  end

  test "方向" do
    assert_true (@p0.angle_to(@p1) < 1.0)
  end
end
