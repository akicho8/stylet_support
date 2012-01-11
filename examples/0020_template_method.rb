# -*- coding: utf-8 -*-
require File.expand_path(File.join(File.dirname(__FILE__), "../lib/stylet"))

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
