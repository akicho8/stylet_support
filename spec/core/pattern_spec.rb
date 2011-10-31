# -*- coding: utf-8 -*-
require "spec_helper"

describe Pattern do
  def create_random_ary(size, count)
    x = Pattern::Random.new(0)
    ary = Array.new(size).fill(0)
    count.times {ary[x.get_next(size)] += 1}
    ary
  end

  it "random" do
    ary = create_random_ary(10, 1000)
    (0 < ary.min).should == true
    (0 < ary.max).should == true
  end

  def create_pattern_ary(obj, count)
    ary = Array.new(Mino::Classic.list.size).fill(0)
    count.times {ary[obj.get_next] += 1}
    ary
  end

  it "history_pattern" do      # バラツキのあるクラス用
    num = 300                   # ブロック１つ当たりの予想出現回数
    gap = 20                    # 出現回数の予想ばらつき
    ary = create_pattern_ary(Pattern::History.new(0), Mino::Classic.list.size*num)
    ((num-gap) < ary.min && ary.max < (num + gap)).should == true
  end

  it "shuffle_pattern - 大きな間隔で出現率は一致するクラス用" do
    num = 100
    ary = create_pattern_ary(Pattern::Shuffle.new(0), Mino::Classic.list.size * num)
    ary.min.should == num
    ary.max.should == num
  end

  it "original_pattern" do
    obj = Pattern::Original.new("bo")
    ary = []
    4.times {ary << obj.get_next}
    ary.should == ["b", "o", nil, nil]
  end

  # 履歴機能テスト
  it "original_pattern_rec" do
    x = Pattern::OriginalRec.new("bo")
    3.times{x.get_next2}
    x.history.should == ["b", "o", nil]
  end

  context "最初のブロックは黄緑紫がでない" do
    before do
      @hash = Hash.new(0)
      300.times{
        @hash[Pattern::History.new.get_next2] += 1
        @hash[Pattern::Shuffle.new.get_next2] += 1
      }
    end
    it "最初に登場するブロックは4種類に限定されている" do
      @hash.size.should == 4
    end
  end
end
