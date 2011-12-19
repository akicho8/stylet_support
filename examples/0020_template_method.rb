# -*- coding: utf-8 -*-
# テンプレートメソッドパターン
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))

class App < Stylet::Base
  def update
    super
    gputs(SDL::Mouse.state.inspect)
  end
end

App.main_loop
