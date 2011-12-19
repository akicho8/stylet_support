# -*- coding: utf-8 -*-
module Stylet
  class CheckFPS
    MSECOND = 1000.0

    attr_reader :fps

    #
    # blockにはミリ秒単位で現在の時間を返すブロックを指定する
    #
    def initialize(&block)
      @block = block || proc{(Time.now.to_f * MSECOND).to_i}
      @old_time = @block.call
      @fps = 0
      @count = 0
    end

    #
    # 毎フレーム呼ぶことでフレーム数を調べられる
    #
    def update
      @count += 1
      v = @block.call
      usetime = v - @old_time
      if usetime > MSECOND
        @old_time = v
        @fps = @count
        @count = 0
      end
      self
    end
  end
end

if $0 == __FILE__
  obj = Stylet::CheckFPS.new
  sleep(0.5)
  obj.update
  sleep(0.5)
  obj.update
  p obj.fps
end
