$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/.."))
require "test_helper"

class TestMino < Test::Unit::TestCase

  def test_s_strsplit
    expected = [
      [[".", ".", "."], ["o", "o", "o"], [".", ".", "."]],
      [[".", "o", "."], [".", "o", "."], [".", "o", "."]],
    ]
    mino_str = <<-END
     ...
     ooo
     ...
      ---
     .o.
     .o.
     .o.
    END
    assert_equal(expected, Mino::Classic::Base.str_split(mino_str))
  end

  def test_range_vicinity
    assert_equal(4, Mino::Classic::Red.range_vicinity)
    assert_equal(2, Mino::Classic::Yellow.range_vicinity)
    assert_equal(3, Mino::Classic::Blue.range_vicinity)
    assert_equal(3, Mino::Classic::Cyan.range_vicinity)
  end

  def test_field_area
    field_area = Mino::Classic.field_area
    assert_equal([4, 4], [field_area.width, field_area.height])
  end

  def test_color_to_mino_index
    assert_equal(6, Mino::Classic.color_to_mino_index("赤"))
    assert_equal(6, Mino::Classic.color_to_mino_index(6))
    assert_equal(6, Mino::Classic.color_to_mino_index("6"))
    assert_equal(6, Mino::Classic.color_to_mino_index("r"))
    assert_equal(6, Mino::Classic.color_to_mino_index("Red"))
    assert_equal("012", Mino::Classic.pattern_to_index_str_pattern("黄b2"))
    assert_equal("ybo", Mino::Classic.pattern_to_alpha_str_pattern("黄b2"))
    assert_equal("黄青橙", Mino::Classic.pattern_to_kanji_str_pattern("黄b2"))
    # assert_equal(["0", "1", "2"], ["黄","b","2"].pattern_to_index_str_pattern) if false
  end

  def test_get_cell_num
    assert_equal(4, Mino::Classic.create("y").class.get_cell_num)
    assert_equal(4, Mino::Classic.create("r").class.get_cell_num)
  end

  def test_equal
    assert_equal(true,  Mino::Classic::Red.new == Mino::Classic::Red.new)      # 内容が同じ
    assert_equal(false, Mino::Classic::Red.new.equal?(Mino::Classic::Red.new)) # 内容が同じでも異なるオブジェクト
    assert_equal(false, Mino::Classic::Red.new == Mino::Classic::Blue.new)     # ブロックの種類が違う

    # 座標が違う
    a = Mino::Classic::Red.new
    b = Mino::Classic::Red.new
    a.x += 1
    assert_equal(true, a != b)

    # 方向が違う
    a = Mino::Classic::Red.new
    b = Mino::Classic::Red.new
    a.dir.set("right")
    b.dir.set("left")
    assert_equal(true, a != b)
  end

  def test_first_appear?
    assert_equal([false, true, true, false, false, true, true], Mino::Classic.list.collect{|klass|klass.first_appear?})
    assert_equal([true, true, true, true, true, true, true], Mino::World.list.collect{|klass|klass.first_appear?})
  end

  def test_mino_rotate_all
    out = ""
    Mino::Classic.list.each {|klass|
      Point::DIR_N.times{|dir|
        field = Field.new
        mino = klass.new
        mino.dir.set(dir)
        mino.attach(field)
        mino.puton
        out << field.to_s
      }
    }
    minofile = File.join(File.dirname(__FILE__), "test_mino.dat")
    assert_equal(out, File.readlines(minofile).join(""))
  end

  def test_rotate_with_correct!
    expected = <<-END
....
.c..
ccc.
....
    END
    field = Field.new
    mino = Mino::Classic::Cyan.new
    mino.dir.set(Point::UP)
    mino.attach(field)
    mino.puton
    assert_equal(expected, field.to_s)
    mino.putoff
    3.times {assert_equal(true, mino.rotate_with_correct!)} # 左3回転
    assert_equal(true, mino.move(Point::LEFT)) # 左移動
    assert_equal(true, mino.rotate_with_correct!) # 左回転(壁補正発生)
    mino.puton
    assert_equal(expected, field.to_s)
  end
end
