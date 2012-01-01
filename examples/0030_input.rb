# -*- coding: utf-8 -*-
# キーボードの入力チェック
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))

class Player
  include Stylet::Input::Base
  include Stylet::Input::StandardKeybord

  def initialize(base)
    super if defined? super
    @base = base
  end

  def update
    super if defined? super
    key_counter_update_all
    @base.vputs(to_s)
    @base.vputs(axis_angle_index.to_s)
    @base.vputs(axis_angle.to_s)
  end
end

class App < Stylet::Base
  def before_main_loop
    super
    @player = Player.new(self)
  end

  def update
    super
    @player.update
  end
end

App.main_loop
