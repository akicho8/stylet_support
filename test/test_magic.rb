require "test_helper"

class TestMagic < Test::Unit::TestCase
  sub_test_case "整数系" do
    test "sin/cos" do
      assert_equal 0, Magic._rsin(0)
      assert_equal Magic.one, Magic._rcos(0)
    end

    test "sinとcosとatan2の整合性確認" do
      n = 64
      r = (0..n).collect {|i|
        r = (Magic.one_round * i / n) % Magic.one_round
        x = Magic._rcos(r)
        y = Magic._rsin(r)
        dir = Magic.iangle(0, 0, x, y)
        r == dir
      }.all?

      assert { r }
    end

    test "二点間の角度を求める" do
      assert_equal Magic.one_round / 4, Magic.iangle(0, 0, 0, 1)
    end
  end

  sub_test_case "一周も角度も小数で表す系" do
    test "sin/cos" do
      assert { Magic.rsin(0) == 0.0 }
      assert { Magic.rcos(0) == 1.0 }
    end

    test "sinとcosとatan2の整合性確認" do
      n = 32
      r = (0..n).collect {|i|
        r = 1.0 * i / n % 1.0
        x = Magic.rcos(r)
        y = Magic.rsin(r)
        dir = Magic.angle(0, 0, x, y)
        r == dir
      }.all?
      assert { r }
    end
  end

  test "時計の時で方向指定" do
    assert { Magic.clock(0) == 0.75 }
    assert { Magic.clock(3) == 0.0 }
    assert { Magic.clock(6) == 0.25 }
    assert { Magic.clock(9) == 0.5 }
    assert { Magic.clock(12) == 0.75 }
  end

  test "方向を抽象化" do
    assert { Magic.r0 == Magic.clock(3) }
    assert { Magic.r45 * 10000 == (Magic.clock(4, 30) * 10000).round }
    assert { Magic.r90 == Magic.clock(6) }
    assert { Magic.r180 == Magic.clock(9) }
  end

  test "左右どちらにいるか？" do
    assert { Magic.cright?(Magic.clock(3)) }
    assert { Magic.cleft?(Magic.clock(9)) }
  end
end
