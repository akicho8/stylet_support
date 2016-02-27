# -*- coding: utf-8 -*-
require "test_helper"

class TestFee < Test::Unit::TestCase
  sub_test_case "整数系" do
    test "sin/cos" do
      assert_equal 0, Fee._rsin(0)
      assert_equal Fee.one, Fee._rcos(0)
    end

    test "sinとcosとatan2の整合性確認" do
      n = 64
      r = (0..n).collect {|i|
        r = (Fee.one_round * i / n) % Fee.one_round
        x = Fee._rcos(r)
        y = Fee._rsin(r)
        dir = Fee.iangle(0, 0, x, y)
        r == dir
      }.all?
      assert_true r
    end

    test "二点間の角度を求める" do
      assert_equal Fee.one_round / 4, Fee.iangle(0, 0, 0, 1)
    end
  end

  sub_test_case "一周も角度も小数で表す系" do
    test "sin/cos" do
      assert_equal 0.0, Fee.rsin(0)
      assert_equal 1.0, Fee.rcos(0)
    end

    test "sinとcosとatan2の整合性確認" do
      n = 32
      r = (0..n).collect {|i|
        r = 1.0 * i / n % 1.0
        x = Fee.rcos(r)
        y = Fee.rsin(r)
        dir = Fee.angle(0, 0, x, y)
        r == dir
      }.all?
      assert_true r
    end
  end

  test "時計の時で方向指定" do
    assert_equal 0.75, Fee.clock(0)
    assert_equal 0.0, Fee.clock(3)
    assert_equal 0.25, Fee.clock(6)
    assert_equal 0.5, Fee.clock(9)
    assert_equal 0.75, Fee.clock(12)
  end

  test "方向を抽象化" do
    assert_equal Fee.clock(3), Fee.r0
    assert_equal (Fee.clock(4, 30) * 10000).round, Fee.r45 * 10000
    assert_equal Fee.clock(6), Fee.r90
    assert_equal Fee.clock(9), Fee.r180
  end

  test "左右どちらにいるか？" do
    assert_true Fee.cright?(Fee.clock(3))
    assert_true Fee.cleft?(Fee.clock(9))
  end
end
