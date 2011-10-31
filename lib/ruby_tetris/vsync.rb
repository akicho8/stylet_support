# -*- coding: utf-8 -*-
# フレーム数を指定してウェイトを取る

class VSyncWait
  MSECOND = 1000

  def self.time_out(fps)
    object = new(fps)
    loop do
      yield
      object.wait
    end
  end

  # blockにはミリ秒単位で現在の時間を返すブロックを指定する
  def initialize(fps=60, &block)
    @fps = fps.to_i
    @block = block || proc{(Time.now.to_f * 1000.0).to_i}
    @old_time = @block.call
  end

  # Vsync待ち相当のウェイト
  def wait
    return if @fps == 0
    loop do
      v = @block.call
      usetime = v - @old_time
      if usetime > MSECOND / @fps
        @old_time = v
        break
      end
      yield if block_given?
    end
  end
end

class CheckFPS
  MSECOND = 1000
  attr_reader :fps

  # blockにはミリ秒単位で現在の時間を返すブロックを指定する
  def initialize(&block)
    @block = block || proc{(Time.now.to_f * 1000.0).to_i}
    @old_time = @block.call
    @fps = 0
    @count = 0
  end

  # 毎フレーム呼ぶことでフレーム数を調べられる
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

if $0 == __FILE__
  count = 3
  puts "#{count}秒間カウントするテスト"
  puts "Timeクラス使用版"
  x = VSyncWait.new(1)
  count.times{|i| puts i; x.wait}

  puts "SDL関数使用版"
  require "rubygems"
  require "sdl"
  x = VSyncWait.new(1) {SDL::getTicks}
  count.times{|i| puts i; x.wait}

  puts "time_out試用版"
  i = 0
  VSyncWait.time_out(1){
    puts i
    i += 1
    break if i == count
  }
end
