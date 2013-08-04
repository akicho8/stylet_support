# -*- coding: utf-8 -*-
require_relative "setup"

class App < Stylet::Base
  def before_main_loop
    super
    self.title = "テンプレートメソッドパターン"
  end

  def update
    super
    vputs "Hello, world."
  end
end

App.main_loop
