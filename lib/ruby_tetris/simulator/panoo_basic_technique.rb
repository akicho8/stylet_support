#!/usr/local/bin/ruby -Ku


$LOAD_PATH << '..'
require "simulator"

library = [
  {
    :title => "青のとばし",
    :author => "ぱのお",
    :date => "",
    :url => "http://www.inagaki.nuie.nagoya-u.ac.jp/person/kushida/tetris/jump.html",
    :difficulty => 4,
    :comment => "右溜めBAB",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    .......b..
    .....ppb..
    ....ppbb..
    EOT
    :input => %[r* r r Br r Ar Br d *],
  },

  {
    :title => "赤のとばし",
    :author => "ぱのお",
    :date => "",
    :url => "http://www.inagaki.nuie.nagoya-u.ac.jp/person/kushida/tetris/jump.html",
    :difficulty => 1,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "r",
    :field => <<-EOT,
    ..b.......
    bbb....o..
    bbbgg.ro..
    bcggggroo.
    cccggrrrr.
    EOT
    :input => %[Ar* Br r r Ar d *],
  },

  {
    :title => "青の回し",
    :author => "ぱのお",
    :date => "",
    :url => "http://www.inagaki.nuie.nagoya-u.ac.jp/person/kushida/tetris/blue.html",
    :difficulty => 1,
    :comment => "2回転だけで移動",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    ..g.......
    ogg.......
    og........
    oo...ooooo
    ryy.yyooc.
    ryy.yyoccc
    EOT
    :input => %[B* . B d *],
  },

  {
    :title => "まぐろの冬眠",
    :author => "ぱのお",
    :date => "",
    :url => "http://www.inagaki.nuie.nagoya-u.ac.jp/person/kushida/tetris/blue2.html",
    :difficulty => 2,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    ...o......
    .oooppc...
    ...ppccc..
    EOT
    :input => %[Bl* l Bl l Bl A d *],
  },

  {
    :title => "左に乗せる",
    :author => "ぱのお",
    :date => "",
    :url => "http://www.inagaki.nuie.nagoya-u.ac.jp/person/kushida/tetris/blue.html",
    :difficulty => 4,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    ccc.......
    pcyy......
    ppyy......
    EOT
    :input => %[Bl* Al l d *],
  },

  {
    :title => "T.J!氏ありがとうスペシャル",
    :author => "ぱのお",
    :date => "",
    :url => "http://www.inagaki.nuie.nagoya-u.ac.jp/person/kushida/tetris/blue2.html",
    :difficulty => 4,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    ......c...
    .....cc...
    EOT
    :input => %[r* Br Ar Cr Ar d *],
  },

  {
    :title => "回転入れ",
    :author => "ぱのお",
    :date => "",
    :url => "http://www.inagaki.nuie.nagoya-u.ac.jp/person/kushida/tetris/blue2.html",
    :difficulty => 1,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    .bbb......
    yy.b.yy...
    yy...yy...
    EOT
    :input => %[A* C d *],
  },

  {
    :title => "与作は木を切る",
    :author => "ぱのお",
    :date => "",
    :url => "http://www.inagaki.nuie.nagoya-u.ac.jp/person/kushida/tetris/blue2.html",
    :difficulty => 1,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    .....oo...
    ......o...
    ....c.o...
    EOT
    :input => %[A* l B d *],
  },

  {
    :title => "超真空入れ",
    :author => "ぱのお",
    :date => "",
    :url => "http://www.inagaki.nuie.nagoya-u.ac.jp/person/kushida/tetris/blue2.html",
    :difficulty => 2,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "b",
    :field => <<-EOT,
    ..oo......
    ...o......
    ...oc.....
    p..ccc....
    EOT
    :input => %[Bl* l l l A B d *],
  },

  {
    :title => "脱・コンコン地獄",
    :author => "ぱのお",
    :date => "",
    :url => "http://www.inagaki.nuie.nagoya-u.ac.jp/person/kushida/tetris/konkon.html",
    :difficulty => 3,
    :comment => "",
    :controller => SimulateController.new,
    :pattern => "o",
    :field => <<-EOT,
    ..rbb.....
    p.rb......
    pprbg.....
    bprgg.....
    bbbgyy....
    EOT
    :input => %[A* r l+ Al Cl d *],
  },

]

if $0 == __FILE__
  library.each{|e| break if Simulator.start_auto(e, 60) == :break}
  exit
  Simulator.start_auto(library[0],30)
  Simulator.start_auto(library.reverse.find{|e|!e[:input].nil?}, 10)
  Simulator.start(library.reverse.find{|e|!e[:input].nil?}, 60)
end

library
