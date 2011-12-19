require File.expand_path(File.join(File.dirname(__FILE__), "point"))

module Stylet
  module Mouse
    attr_reader :mpos, :mouse_btA, :mouse_btB, :mouse_btC

    def initialize(*)
      super if defined? super
      @mpos = Point.new(0, 0)
      @before_mpos = @mpos.clone
    end

    def polling
      super if defined? super
      @before_mpos = @mpos.clone
      @mpos.x, @mpos.y, @mouse_btA, @mouse_btB, @mouse_btC = SDL::Mouse.state
    end

    def mouse_moved?
      @before_mpos != @mpos
    end
  end
end
