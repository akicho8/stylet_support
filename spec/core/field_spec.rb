# -*- coding: utf-8 -*-
require "spec_helper"

describe Field do
  it "get" do
    f = Field.new
    f.get(0, f.right).set("y")
    f.get(-1, 0).should == nil
  end

  it "clear?" do
    f = Field.new
    f.clear?.should == true
    f.get(0, 0).set("y")
    f.clear?.should == false
    f.get(0, 0).clear!
    f.clear?.should == true
  end

  it "exist?" do
    f = Field.new
    f.exist?(-1, -1).should == true
    f.exist?(0, 0).should == false
    f.get(0, 0).set("y")
    f.exist?(0, 0).should == true
  end

  it "writeable?" do
    f = Field.new
    points = [Point.new(0, 0), Point.new(1, 0)]
    f.writeable?(points).should == true
    f.get(0, 0).set("y")
    f.writeable?(points).should == false
    f.get(0, 0).clear!
    f.writeable?(points).should == true
  end

  it "get_top" do
    f = Field.new
    f.get(0, 1).set("y")
    f.get_top(0).should == 1
    f.get(1, 2).set("y")
    f.get_top(1).should == 2
    f.get_top.should == 1
    f.get_top(-1).should == 0
    f.get_top(10).should == 0
  end

  it "get_top2" do
    f = Field.new([10,22])
    # 両端にはフィールドの高さに相当するセルがあるとみなす。
    f.get_top2(-1).should == 22
    f.get_top2(10).should == 22
    f.get_top2( 1).should == 0
  end

  it "roughness" do
    f = Field.new([10, 20])
    f.get(0, 0).set("y")
    f.get(1, f.height / 2).set("y")
    f.roughness.should == f.height
  end

  it "roughness2" do
    f = Field.new([10, 22], <<-EOT)
...r
.r.r
.r.r
    EOT
    f.roughness2(0).should == 22+2  # 0桁目の左は22段の差、右は2段の差、その合計が段差数になる
    f.roughness2(1).should == 2+2   # 1桁目の左は 2段の差、右は2段の差、その合計が段差数になる
    f.roughness2(2).should == 2+3   # 1桁目の左は 2段の差、右は3段の差、その合計が段差数になる
    f.roughness2(10).should == 22+0 # 10桁目の左は 22段の差、右は0段の差、その合計が段差数になる(フィールドの外)
  end

  it "hole?" do
    f = Field.new([10, 22], <<-EOT)
...r
r.rr
r.rr
    EOT
    f.hole?(1).should == true  # 1桁目は左右に囲まれて穴になっている
    f.hole?(2).should == false # 2桁目は傾斜だから穴ではない
  end

  it "flat?" do
    f = Field.new([4,22],<<-EOT)
rrrr
    EOT
    f.flat?.should == true         # ブロックの一番上が横一列になっていたら平ら。
    Field.new.flat?.should == true # フィールドが空の場合も、もちろん平ら。
  end

  it "damage" do
    f = Field.new([4,4])
    f.get(0, 0).set("y")
    f.damage.should == 3
  end

  it "clone" do
    f0, f1 = get_mino_write_field(Mino::Classic::Cyan, Mino::Classic::Blue)
    (f0 == f0.clone).should == true
    (f1 == f0.clone).should == false
  end

  it "EQ" do
    f0, f1 = get_mino_write_field(Mino::Classic::Cyan, Mino::Classic::Blue)
    (f0 == f0).should == true
    (f1 == f1).should == true
    (f0 == f1).should == false
  end

  it "cell_count" do
    f = Field.new([10,22],<<-EOT)
.r.r
.r.r
    EOT
    f.cell_count.should == 4 # "r" が 4 つ
  end

  ################################################################################
  it "clear!" do
    f = Field.new([4,4])
    f.get(0,0).set("c")
    f.clear?.should == false
    f.clear!
    f.clear?.should == true
  end

  it "replace" do
    f = Field.new([2,2])
    f.get(0, 0).set("o")
    f.replace(<<-EOT)
    c
    EOT
    f.to_s.should == <<-EOT
..
c.
EOT
  end

  it "new" do
    f = Field.new([2, 3], <<-EOT)
    c.
    .o
    EOT
    f.to_s(:ustrip => true).should == <<-EOT
c.
.o
    EOT
  end

  it "new2" do
  field = <<-EOT
...o.o....
...o.o....
EOT
    f = Field.new([10,22],field)
    f.to_s(:top => 20).should == field
  end

  # AC するのに必要なセル数、つまり "." の数を取得する
  it "get_cell_count_for_ac" do
  field = <<-EOT
o.
..
EOT
    f = Field.new([2,2],field)
    f.get_cell_count_for_ac.should == 3
  end

  it "delete_lines" do
    x = Field.new([5, 10], <<-EOT)
ooo.
bbb.
ooo.
bbb.
EOT
    x.reject_lines([9,7])
    x.inspect.should == <<-EOT
 8|ooo..|
 9|ooo..|
   -----
   01234
EOT
  end

  it "raise_line" do
    x = Field.new([5,10],<<E)
ooo.
bbb.
ooo.
bbb.
E
    x.rise_line([LifeCell.new, LifeCell.new("o"), LifeCell.new, LifeCell.new("y"), LifeCell.new])
    x.inspect.should == <<-EOT
 5|ooo..|
 6|bbb..|
 7|ooo..|
 8|bbb..|
 9|.o.y.|
   -----
   01234
EOT
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
