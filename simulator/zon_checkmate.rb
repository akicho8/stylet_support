#!/usr/local/bin/ruby -Ku


$LOAD_PATH << '..'
require "simulator"

library = [
  {
    :title => "回転入れ",
    :author => "ZON",
    :date => "2000-01-29",
    :url => "http://homepage3.nifty.com/tgm/bbslog0001.html",
    :difficulty => 5,
    :comment => "第一手が難しい",
    :controller => SimulateController.new,
    :pattern => "bryob",
    :field => <<-EOS,
    cccc......
    ccccc.....
    cccccc...c
    ccccccc...
    ccccccc...
    EOS
    :input => <<-EOS
    r| d
    * r d
    r| d
    Br* r| B d
    r| d
    *
    EOS
  },

  {
    :title => "ダブル回転入れ",
    :author => "ZON",
    :date => "1999-10-15",
    :url => "http://homepage3.nifty.com/tgm/bbslog9910.html",
    :difficulty => 2,
    :comment => "そんなに難しくはないです",
    :controller => SimulateController.new,
    :pattern => "prob",
    :field => <<-EOS,
    yy......yy
    yy......yy
    yyy....yyy
    EOS
    :input => <<-EOS
    Al| d
    u_ d
    Br* r| B d
    A* C d
    *
    EOS
  },

  {
    :title => "与作",
    :author => "ZON",
    :date => "1999-10-15",
    :url => "http://homepage3.nifty.com/tgm/bbslog9910.html",
    :difficulty => 3,
    :comment => "最初の水色の置き方がポイント",
    :controller => SimulateController.new,
    :pattern => "cobcb",
    :field => <<-EOS,
    .....rrrrr
    ....rrrrrr
    ....rrrrrr
    ....rrrrrr
    .r..rrrrrr
    EOS
    :input => <<-EOS
    * l l d
    Bl| r . r d
    Al| B d
    Bl| A d
    Al| d
    *
    EOS
  },
]

if $0 == __FILE__
  library.each{|e| break if Simulator.start_auto(e, 60) == :break}
  exit
  Simulator.start_auto(library[0],30)
  Simulator.start(library.reverse.find{|e|!e[:input].nil?}, 60)
  Simulator.start_auto(library.reverse.find{|e|!e[:input].nil?}, 60)
end

library
