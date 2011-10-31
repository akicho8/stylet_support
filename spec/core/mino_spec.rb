# -*- coding: utf-8 -*-
require "spec_helper"

describe Mino do
  it "s_strsplit" do
    expected = [
      [[".", ".", "."], ["o", "o", "o"], [".", ".", "."]],
      [[".", "o", "."], [".", "o", "."], [".", "o", "."]],
    ]
    mino_str = <<-EOT
     ...
     ooo
     ...
      ---
     .o.
     .o.
     .o.
    EOT
    Mino::Classic::Base.str_split(mino_str).should == expected
  end

  it "range_vicinity" do
    Mino::Classic::Red.range_vicinity.should == 4
    Mino::Classic::Yellow.range_vicinity.should == 2
    Mino::Classic::Blue.range_vicinity.should == 3
    Mino::Classic::Cyan.range_vicinity.should == 3
  end

  it "field_area" do
    field_area = Mino::Classic.field_area
    [field_area.width, field_area.height].should == [4, 4]
  end

  it "color_to_mino_index" do
    Mino::Classic.color_to_mino_index("赤").should == 6
    Mino::Classic.color_to_mino_index(6).should == 6
    Mino::Classic.color_to_mino_index("6").should == 6
    Mino::Classic.color_to_mino_index("r").should == 6
    Mino::Classic.color_to_mino_index("Red").should == 6
    Mino::Classic.pattern_to_index_str_pattern("黄b2").should == "012"
    Mino::Classic.pattern_to_alpha_str_pattern("黄b2").should == "ybo"
    Mino::Classic.pattern_to_kanji_str_pattern("黄b2").should == "黄青橙"
  end

  it "get_cell_num" do
    Mino::Classic.create("y").class.get_cell_num.should == 4
    Mino::Classic.create("r").class.get_cell_num.should == 4
  end

  it "equal" do
    (Mino::Classic::Red.new == Mino::Classic::Red.new).should == true     # 内容が同じ
    Mino::Classic::Red.new.equal?(Mino::Classic::Red.new).should == false # 内容が同じでも異なるオブジェクト
    (Mino::Classic::Red.new == Mino::Classic::Blue.new).should == false   # ブロックの種類が違う

    # 座標が違う
    a = Mino::Classic::Red.new
    b = Mino::Classic::Red.new
    a.x += 1
    (a != b).should == true

    # 方向が違う
    a = Mino::Classic::Red.new
    b = Mino::Classic::Red.new
    a.dir.set("right")
    b.dir.set("left")
    (a != b).should == true
  end

  it "first_appear?" do
    Mino::Classic.list.collect{|klass|klass.first_appear?}.should == [false, true, true, false, false, true, true]
    Mino::World.list.collect{|klass|klass.first_appear?}.should == [true, true, true, true, true, true, true]
  end

  it "mino_rotate_all" do
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
    out.should == Pathname(__FILE__).dirname.join("mino_spec.txt").expand_path.read
  end

  it "rotate_with_correct!" do
    expected = <<-EOT
....
.c..
ccc.
....
    EOT
    field = Field.new
    mino = Mino::Classic::Cyan.new
    mino.dir.set(Point::UP)
    mino.attach(field)
    mino.puton
    field.to_s.should == expected
    mino.putoff
    3.times{mino.rotate_with_correct!} # 左3回転
    mino.move(Point::LEFT)             # 左移動
    mino.rotate_with_correct!          # 左回転(壁補正発生)
    mino.puton
    field.to_s.should == expected
  end
end
