$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/.."))
require "test_helper"

class TestField < Test::Unit::TestCase
  def test_get
    f = Field.new
    f.get(0, f.right).set("y")
    assert_equal(nil, f.get(-1, 0))
  end

  def test_clear?
    f = Field.new
    assert(f.clear?)
    f.get(0, 0).set("y")
    assert(!f.clear?)
    f.get(0, 0).clear!
    assert(f.clear?)
  end

  def test_exist?
    f = Field.new
    assert(f.exist?(-1, -1))
    assert(!f.exist?(0, 0))
    f.get(0, 0).set("y")
    assert(f.exist?(0, 0))
  end

  def test_writeable?
    f = Field.new
    points = [Point.new(0, 0), Point.new(1, 0)]
    assert(f.writeable?(points))
    f.get(0, 0).set("y")
    assert(!f.writeable?(points))
    f.get(0, 0).clear!
    assert(f.writeable?(points))
  end

  def test_get_top
    f = Field.new
    f.get(0, 1).set("y")
    assert_equal(1, f.get_top(0))
    f.get(1, 2).set("y")
    assert_equal(2, f.get_top(1))
    assert_equal(1, f.get_top)
    assert_equal(0, f.get_top(-1))
    assert_equal(0, f.get_top(10))
  end

  def test_get_top2
    f = Field.new([10,22])
    assert_equal(22, f.get_top2(-1)) # 両端にはフィールドの高さに相当するセルがあるとみなす。
    assert_equal(22, f.get_top2(10))
    assert_equal(0, f.get_top2( 1))
  end

  def test_roughness
    f = Field.new([10, 20])
    f.get(0, 0).set("y")
    f.get(1, f.height/2).set("y")
    assert_equal(f.height, f.roughness)
  end

  def test_roughness2
    f = Field.new([10,22],<<-END)
...r
.r.r
.r.r
    END
    assert_equal(22+2, f.roughness2(0)) # 0桁目の左は22段の差、右は2段の差、その合計が段差数になる
    assert_equal( 2+2, f.roughness2(1)) # 1桁目の左は 2段の差、右は2段の差、その合計が段差数になる
    assert_equal( 2+3, f.roughness2(2)) # 1桁目の左は 2段の差、右は3段の差、その合計が段差数になる
    assert_equal(22+0, f.roughness2(10)) # 10桁目の左は 22段の差、右は0段の差、その合計が段差数になる(フィールドの外)
  end

  def test_hole?
    f = Field.new([10,22],<<-END)
...r
r.rr
r.rr
    END
    assert_equal(true,  f.hole?(1)) # 1桁目は左右に囲まれて穴になっている
    assert_equal(false, f.hole?(2)) # 2桁目は傾斜だから穴ではない
  end

  def test_flat?
    f = Field.new([4,22],<<-END)
rrrr
    END
    assert(f.flat?)             # ブロックの一番上が横一列になっていたら平ら。
    assert(Field.new.flat?)     # フィールドが空の場合も、もちろん平ら。
  end

  def test_damage
    f = Field.new([4,4])
    f.get(0, 0).set("y")
    assert_equal(3, f.damage)
  end

  def test_clone
    f0, f1 = get_mino_write_field(Mino::Classic::Cyan, Mino::Classic::Blue)
    assert_equal(true, f0 == f0.clone)
    assert_equal(false, f1 == f0.clone)
  end

  def test_EQ
    f0, f1 = get_mino_write_field(Mino::Classic::Cyan, Mino::Classic::Blue)
    assert_equal(true, f0 == f0)
    assert_equal(true, f1 == f1)
    assert_equal(false, f0 == f1)
  end

  def test_cell_count
    f = Field.new([10,22],<<-END)
.r.r
.r.r
    END
    assert_equal(4, f.cell_count) # "r" が 4 つ
  end

  ################################################################################
  def test_clear!
    f = Field.new([4,4])
    f.get(0,0).set("c")
    assert(!f.clear?)
    f.clear!
    assert(f.clear?)
  end

  def test_replace
    f = Field.new([2,2])
    f.get(0,0).set("o")
    f.replace(<<-END)
    c
    END
    assert_equal(<<-END, f.to_s)
..
c.
END
  end

  def test_new
    f = Field.new([2,3],<<-END)
    c.
    .o
    END
    assert_equal(<<-END, f.to_s(:ustrip => true))
c.
.o
    END
  end

  def test_new2
  field = <<-END
...o.o....
...o.o....
END
    f = Field.new([10,22],field)
    assert_equal(field, f.to_s(:top => 20))
  end

  # AC するのに必要なセル数、つまり "." の数を取得する
  def test_get_cell_count_for_ac
  field = <<-END
o.
..
END
    f = Field.new([2,2],field)
    assert_equal(3, f.get_cell_count_for_ac)
  end

  def test_delete_lines
    x = Field.new([5,10],<<END)
ooo.
bbb.
ooo.
bbb.
END
    x.reject_lines([9,7])
    assert_equal(<<END, x.inspect)
 8|ooo..|
 9|ooo..|
   -----
   01234
END
  end

  def test_raise_line
    x = Field.new([5,10],<<E)
ooo.
bbb.
ooo.
bbb.
E
    x.rise_line([LifeCell.new, LifeCell.new("o"), LifeCell.new, LifeCell.new("y"), LifeCell.new])
    assert_equal(<<END, x.inspect)
 5|ooo..|
 6|bbb..|
 7|ooo..|
 8|bbb..|
 9|.o.y.|
   -----
   01234
END
  end

  private
  def get_mino_write_field(*klass)
    klass.map {|k|
      f = Field.new
      b = k.new
      b.attach(f)
      b.puton
      f
    }
  end
end
