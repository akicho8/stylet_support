#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-

$LOAD_PATH << '..'
require "simulator"

library = [
  {
    :title => "水色の渡し",
    :author => "",
    :date => "",
    :url => "",
    :difficulty => nil,
    :comment => "http://www.google.co.jp/",
    :controller => SimulateController.new,
    :pattern => "ob",
    :input => [["R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1", "R1"], "R", "R1", "R", "R1", "R", "R1", "R", "D", ["", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "", ""]],
    :field => <<-EOS
    rrrrrr....
    rrrrrr.r..
    rrrrrrrr..
    rrrrrrrrr.
    rrrrrrrrr.
    rrrrrrrrr.
    EOS
  },

  {
    :title => "1ライン消しを2ライン消しに育てる",
    :author => "",
    :date => "2000-07-23",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "gc",
    :input => nil,
    :field => <<-EOS
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    EOS
  },

  {
    :title => "オレンジ回転入れスペシャル",
    :author => "某スレの420",
    :date => "2001-03-11",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "oo",
    :input => nil,
    :field => <<-EOS
    cc........
    ...c.c....
    .c...c....
    cccccc....
    EOS
  },

  {
    :title => "T.J!氏ありがとうスペシャル",
    :author => "ぱのお",
    :date => "",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "b",
    :input => nil,
    :field => <<-EOS
    ......o...
    .....oooo.
    .o.o.ooooo
    .ooo.ooooo
    .ooo.ooooo
    EOS
  },

  {
    :title => "橙で窪みをまたぐ",
    :author => "",
    :date => "2000-12-03",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "o",
    :input => nil,
    :field => <<-EOS
    bbbb.bbb..
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    EOS
  },

  {
    :title => "届くものは回さずに",
    :author => "",
    :date => "2000-08-02",
    :url => "",
    :difficulty => nil,
    :comment => "オリジナル問題",
    :controller => SimulateController.new,
    :pattern => "o",
    :input => nil,
    :field => <<-EOS
    bbbb......
    bbbb......
    bbbb.b....
    bbbb.b....
    bbbbbb.b..
    bbbbbb.b..
    bbbbbbbb..
    bbbbbbbbb.
    bbbbbbbbb.
    EOS
  },

  {
    :title => "青の回転入れ",
    :author => "",
    :date => "2000-07-16",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "pb",
    :input => nil,
    :field => <<-EOS
    bb...bbbb.
    bb...bbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    EOS
  },

  {
    :title => "水色の渡し",
    :author => "",
    :date => "2000-04-17",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "c",
    :input => nil,
    :field => <<-EOS
    .b..b..bb.
    bb..b..bbb
    bb..b..bbb
    bb..b..bbb
    EOS
  },

  {
    :title => "水色の操作は?",
    :author => "",
    :date => "2000-04-17",
    :url => "",
    :difficulty => nil,
    :comment => "左側ならAC",
    :controller => SimulateController.new,
    :pattern => "c",
    :input => nil,
    :field => <<-EOS
    ...bbb....
    ....b.....
    ...bbb....
    ..bbbbb...
    ..bbbbb...
    ..bbbbb...
    ..bbbbb...
    EOS
  },

  {
    :title => "橙の操作は?",
    :author => "",
    :date => "2000-04-17",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "o",
    :input => nil,
    :field => <<-EOS
    bbbbbb....
    bbbbb.....
    bbbbbb....
    bbbbbb....
    bbbbbbb...
    bbbbbbb...
    bbbbbbb...
    EOS
  },

  {
    :title => "橙の操作は?",
    :author => "",
    :date => "2000-07-23",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "o",
    :input => nil,
    :field => <<-EOS
    bbbbbbb...
    bbbbbb....
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbbb..
    EOS
  },

  {
    :title => "青の操作は?",
    :author => "",
    :date => "2000-04-17",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "b",
    :input => nil,
    :field => <<-EOS
    ...ccc....
    ...ccc....
    ...ccc....
    ....coo...
    ...ccco...
    ...ccco...
    ..ccccc...
    EOS
  },

  {
    :title => "水色シンクロ",
    :author => "",
    :date => "2000-04-17",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "c",
    :input => nil,
    :field => <<-EOS
    .bbbb.....
    .bbbb...b.
    .bbbb...bb
    .bbbb...bb
    .bbbbbbbbb
    .bbbbbbbbb
    .bbbbbbbbb
    EOS
  },

  {
    :title => "橙シンクロ",
    :author => "",
    :date => "2000-04-17",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "o",
    :input => nil,
    :field => <<-EOS
    .bbbb.....
    .bbbb.....
    .bbbb...b.
    .bbbb.b.b.
    .bbbbbbbbb
    .bbbbbbbbb
    .bbbbbbbbb
    EOS
  },

  {
    :title => "水色3回転",
    :author => "",
    :date => "2000-02-20",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "c",
    :input => nil,
    :field => <<-EOS
    ....b.....
    .b..bbbbb.
    bb..bbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    EOS
  },

  {
    :title => "赤の飛ばし",
    :author => "",
    :date => "",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "r",
    :input => nil,
    :field => <<-EOS
    .......b..
    .......b..
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    EOS
  },

  {
    :title => "赤の操作は?",
    :author => "",
    :date => "",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "r",
    :input => nil,
    :field => <<-EOS
    bbbbbb....
    bbbbbb....
    bbbbbb.b..
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    EOS
  },

  {
    :title => "赤シンクロ",
    :author => "",
    :date => "",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "r",
    :input => nil,
    :field => <<-EOS
    bbbbbb....
    bbbbbb....
    bbbbbb..b.
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    EOS
  },

  {
    :title => "赤シンクロ",
    :author => "",
    :date => "",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "r",
    :input => nil,
    :field => <<-EOS
    ....bbbbbb
    ....bbbbbb
    ..b.bbbbbb
    .bbbbbbbbb
    .bbbbbbbbb
    .bbbbbbbbb
    .bbbbbbbbb
    EOS
  },

  {
    :title => "緑の軸移動",
    :author => "",
    :date => "",
    :url => "",
    :difficulty => nil,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "g",
    :input => nil,
    :field => <<-EOS
    ........o.
    ..r.ppooob
    ....cppbbb
    ...cccrrrr
    EOS
  },

]

if $0 == __FILE__
  Simulator.start(library[0])
end

library
