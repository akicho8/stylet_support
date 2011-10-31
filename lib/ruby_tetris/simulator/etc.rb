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
    :field => <<-EOT
    rrrrrr....
    rrrrrr.r..
    rrrrrrrr..
    rrrrrrrrr.
    rrrrrrrrr.
    rrrrrrrrr.
    EOT
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
    :field => <<-EOT
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    EOT
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
    :field => <<-EOT
    cc........
    ...c.c....
    .c...c....
    cccccc....
    EOT
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
    :field => <<-EOT
    ......o...
    .....oooo.
    .o.o.ooooo
    .ooo.ooooo
    .ooo.ooooo
    EOT
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
    :field => <<-EOT
    bbbb.bbb..
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    EOT
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
    :field => <<-EOT
    bbbb......
    bbbb......
    bbbb.b....
    bbbb.b....
    bbbbbb.b..
    bbbbbb.b..
    bbbbbbbb..
    bbbbbbbbb.
    bbbbbbbbb.
    EOT
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
    :field => <<-EOT
    bb...bbbb.
    bb...bbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    EOT
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
    :field => <<-EOT
    .b..b..bb.
    bb..b..bbb
    bb..b..bbb
    bb..b..bbb
    EOT
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
    :field => <<-EOT
    ...bbb....
    ....b.....
    ...bbb....
    ..bbbbb...
    ..bbbbb...
    ..bbbbb...
    ..bbbbb...
    EOT
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
    :field => <<-EOT
    bbbbbb....
    bbbbb.....
    bbbbbb....
    bbbbbb....
    bbbbbbb...
    bbbbbbb...
    bbbbbbb...
    EOT
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
    :field => <<-EOT
    bbbbbbb...
    bbbbbb....
    bbbbbbb...
    bbbbbbb...
    bbbbbbbb..
    bbbbbbbb..
    bbbbbbbb..
    EOT
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
    :field => <<-EOT
    ...ccc....
    ...ccc....
    ...ccc....
    ....coo...
    ...ccco...
    ...ccco...
    ..ccccc...
    EOT
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
    :field => <<-EOT
    .bbbb.....
    .bbbb...b.
    .bbbb...bb
    .bbbb...bb
    .bbbbbbbbb
    .bbbbbbbbb
    .bbbbbbbbb
    EOT
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
    :field => <<-EOT
    .bbbb.....
    .bbbb.....
    .bbbb...b.
    .bbbb.b.b.
    .bbbbbbbbb
    .bbbbbbbbb
    .bbbbbbbbb
    EOT
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
    :field => <<-EOT
    ....b.....
    .b..bbbbb.
    bb..bbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    EOT
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
    :field => <<-EOT
    .......b..
    .......b..
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    EOT
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
    :field => <<-EOT
    bbbbbb....
    bbbbbb....
    bbbbbb.b..
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    EOT
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
    :field => <<-EOT
    bbbbbb....
    bbbbbb....
    bbbbbb..b.
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    bbbbbbbbb.
    EOT
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
    :field => <<-EOT
    ....bbbbbb
    ....bbbbbb
    ..b.bbbbbb
    .bbbbbbbbb
    .bbbbbbbbb
    .bbbbbbbbb
    .bbbbbbbbb
    EOT
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
    :field => <<-EOT
    ........o.
    ..r.ppooob
    ....cppbbb
    ...cccrrrr
    EOT
  },

]

if $0 == __FILE__
  Simulator.start(library[0])
end

library
