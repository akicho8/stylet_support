#!/usr/local/bin/ruby -Ku


$LOAD_PATH << '..'
require "simulator"

library = [
  {
    :title => "タイトル1",
    :author => "いぺぱぴ",
    :date => "1999-06-27",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9906.html#990627",
    :difficulty => 1,
    :comment => "コメント",
    :controller => SimulateController.new,
    :pattern => "p",
    :field => <<-EOS,
    ccccccc...
    ccccccc...
    cccccccc..
    ccccccccc.
    EOS
    :input => %[r| B d *],
  },

  {
    :title => "タイトル2",
    :author => "いぺぱぴ",
    :date => "1999-06-27",
    :url => "http://homepage3.nifty.com/tgm/boyakilog9906.html#990627",
    :difficulty => 1,
    :comment => "コメント",
    :controller => SimulateController.new,
    :pattern => "p",
    :field => <<-EOS,
    ccccccc...
    ccccccc...
    cccccccc..
    ccccccccc.
    EOS
    :input => %[r| B d *],
  },
]

# Simulator.start(library[0], 60)
# exit;


if $0 == __FILE__
  library.each{|e| Simulator.start_auto(e, 60) == :break and break}
  exit
  if ARGV.empty?
    Simulator.start_auto(library.reverse.find{|e|!e[:input].nil?}, 60)
  else
    Simulator.start(library.reverse.find{|e|!e[:input].nil?}, 60)
  end
  Simulator.start_auto(library[0],60)
end

library
