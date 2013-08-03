# -*- coding: utf-8 -*-
require_relative "../lib/stylet"

class App < Stylet::Base
  def before_main_loop
    super if defined? super
    self.title = "テンプレートメソッドパターン"
  end

  def update
    super if defined? super
    vputs "Hello, world."
  end
end

App.main_loop
