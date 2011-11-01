# -*- coding: utf-8 -*-

require File.expand_path(File.join(File.dirname(__FILE__), "../lib/ruby_tetris/simulator"))

data = {
  :title => "ブロック表示テスト",
  :controller => SimulateController.new,
  :field => <<-EOS,
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
  EOS
}

[nil, :INSIDE, :OUTSIDE].each{|CONFIG[:edge]|
  Simulator.view(data)
  sleep(2)
}
