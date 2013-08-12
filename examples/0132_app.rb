# -*- coding: utf-8 -*-
require "./setup"

class App < Stylet::Base
end

App.run(:title => "すべて同じオブジェクト") do
  vputs self.object_id
  vputs frame.object_id
  vputs Stylet::Base.active_frame.object_id
end
