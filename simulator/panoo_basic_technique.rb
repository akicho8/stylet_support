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
    :field => <<-EOS,
    .......b..
    .....ppb..
    ....ppbb..
    EOS
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
    :field => <<-EOS,
    ..b.......
    bbb....o..
    bbbgg.ro..
    bcggggroo.
    cccggrrrr.
    EOS
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
    :field => <<-EOS,
    ..g.......
    ogg.......
    og........
    oo...ooooo
    ryy.yyooc.
    ryy.yyoccc
    EOS
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
    :field => <<-EOS,
    ...o......
    .oooppc...
    ...ppccc..
    EOS
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
    :field => <<-EOS,
    ccc.......
    pcyy......
    ppyy......
    EOS
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
    :field => <<-EOS,
    ......c...
    .....cc...
    EOS
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
    :field => <<-EOS,
    .bbb......
    yy.b.yy...
    yy...yy...
    EOS
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
    :field => <<-EOS,
    .....oo...
    ......o...
    ....c.o...
    EOS
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
    :field => <<-EOS,
    ..oo......
    ...o......
    ...oc.....
    p..ccc....
    EOS
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
    :field => <<-EOS,
    ..rbb.....
    p.rb......
    pprbg.....
    bprgg.....
    bbbgyy....
    EOS
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
