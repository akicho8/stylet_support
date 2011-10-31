# -*- coding: utf-8 -*-

$LOAD_PATH << '..'
require "simulator"

data = {
  :title => "ブロック表示テスト",
  :controller => SimulateController.new,
  :field => <<-EOT,
  o...o.o.o.
  oo.o.o.ooo
  r.rr.r.rr.
  r..r.r.rr.
  rrrr.rrrrr
  rrrrrrrrrr
  rrrrrr....
  ........o.
  ..b......o
  ..b..rrrr.
  .cbbyy....
  ccc.yy....
  rrrrrrrrrr
  rrrrrrrrrr
  rrrrrrrrrr
  rrrrrrrrrr
  rrrrrrrrrr
  o.o.o.o.o.
  ...rrrr...
  .o.o.o.o.o
  o.o.o.o.o.
  oooooooooo
  EOT
}

[nil, :INSIDE, :OUTSIDE].each{|CONFIG[:edge]|
  Simulator.view(data)
}
