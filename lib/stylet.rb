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

  def instance
    Base.instance
  end

  def hello_world
    run { vputs "Hello, World" }
  end
end
