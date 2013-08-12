# -*- coding: utf-8 -*-
require_relative 'stylet/version'
require_relative 'stylet/base'
require_relative 'stylet/input'

module Stylet
  extend self

  # スペックを配列で返す
  def suppprt
    @suppprt ||= [].tap do |a|
      a << :sge   if SDL.respond_to?(:autoLock)
      a << :mpeg  if SDL.constants.include?(:MPEG)
      a << :mixer if SDL.constants.include?(:Mixer)
      a << :gl    if SDL.constants.include?(:GL)
    end
  end

  # ショートカット
  #   Stylet.run { vputs "Hello" }
  def run(*args, &block)
    Base.run(*args, &block)
  end

  def frame(&block)
    if block
      if block.arity == 1
        block.call(Base.active_frame)
      else
        Base.active_frame.instance_eval(&block)
      end
    else
      Base.active_frame
    end
  end

  def hello_world
    run { vputs "Hello, World" }
  end
end

module Kernel
  def frame(&block)
    Stylet.frame(&block)
  end
end

# Stylet.run do
#   vputs "a"
#   frame.vputs "b"
#   frame { vputs "c" }
#   frame {|f| f.vputs "d" }
# end
