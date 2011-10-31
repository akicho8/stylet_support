# -*- coding: utf-8 -*-
require "spec_helper"

describe BackTrack do
  context "バックトラックの動作テスト" do
    before do
      # backtrack = BackTrack.new("162405361452016", 10, 20)
      # 積=1212 フィールド=4x10 全てのパターン探索=true
      @backtrack = BackTrack.new("bobo", 4, 10, true)
      @backtrack.backtrack
    end
    subject {@backtrack}
    it {
      subject.result.size.should == 2
    }
    it {subject.result[0].history.size.should == 4}
    it {subject.result[0].history.collect{|v|v.color_char}.join("").should == "bobo"}
    it do
      subject.result[0].to_s(:ustrip => true).should == <<-EOT
bboo
bboo
bboo
bboo
EOT
      subject.result[1].to_s(:ustrip => true).should == <<-EOT
oobb
oobb
oobb
oobb
EOT
    end
  end

  it "ブロックパターンの指定がないときは戻値は空" do
    backtrack = BackTrack.new("")
    backtrack.backtrack
    backtrack.result.should == []
  end

  it "ブロック引数をつけるとバックトラック中の動作を覗き見できる" do
    log = []
    backtrack = BackTrack.new("yy", 4, 10, false) {|field| log << field.clone}
    backtrack.backtrack
    backtrack.result.should == log
  end
end
