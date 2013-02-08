# -*- coding: utf-8 -*-
require "spec_helper"

module Stylet
  describe VSyncWait do
    before do
      @count = 2       # 二回実行
      @frame_count = 1 # 1フレーム = 1000.0/1 = 一秒
    end

    it "一秒を二回待つ" do
      t = Time.now
      x = VSyncWait.new(@frame_count)
      resp = @count.times.collect{|i|
        [i, Time.now].tap{x.wait}
      }
      t = Time.now - t
      t.should >= @count
    end

    it "コードブロック版" do
      t = Time.now
      i = 0
      VSyncWait.time_out(@frame_count){
        break if i == @count
        i += 1
      }
      t = Time.now - t
      t.should >= @count
    end
  end
end
