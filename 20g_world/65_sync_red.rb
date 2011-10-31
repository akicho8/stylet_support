# -*- coding: utf-8 -*-
require "environment"

Library = {
  :title => "右への赤シンクロ→全消し",
  :author => "いぺぱぴ",
  :date => "2000-02-09",
  :url => "",
  :difficulty => 4,
  :comment => "赤シンクロと橙の向きがポイント。",
  :controller => SimulateWithSoundController.new,
  :pattern => "proc",
  :field => <<-EOT,
  bbbbbb....
  bbbbbbb...
  bbbbbbb...
  bbbbbbbb..
  bbbbbbbbb.
  bbbbbbbbb.
  bbbbbbbbb.
  bbbbbbbbb.
  EOT
  :input => <<-EOT,
  Ar| d
  * r . r . Ar| d
  Ar* Cr| d
  r| d *
  EOT
}

if $0 == __FILE__
  Simulator.start(Library)
end
