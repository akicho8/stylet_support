# -*- coding: utf-8 -*-
require "./setup"

class App < Stylet::Base
  def before_run
    super
    self.title = "テンプレートメソッドパターン"
  end

  def update
    super
    vputs "Hello, world."
  end
end

App.run
