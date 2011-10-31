#!/usr/local/bin/ruby -Ku
# -*- coding: utf-8 -*-

$LOAD_PATH << '..'
require "simulator"

cyan_r_control = %[r| d_ B u_ *]
cyan_l_control = %[r| d_ A u_ *]

library = [
  {
    :title => "水色の軸補正 0の列に補正",
    :controller => SimulateDSController.new(0.01),
    :mino_factory => Mino::World,
    :pattern => "c",
    :field => <<-EOT,
    ......rrr.
    ......rrr.
    ......rrr.
    ......rrr.
      EOT
    :input => cyan_r_control,
  },
  {
    :title => "水色の軸補正 信じられないことに7の列に補正",
    :controller => SimulateDSController.new(0.01),
    :mino_factory => Mino::World,
    :pattern => "c",
    :field => <<-EOT,
    ........r.
    ........r.
    ........r.
    ........r.
      EOT
    :input => cyan_r_control,
  },
  {
    :title => "水色の軸補正 7の列にぶつかって8は見ずに0の列に補正",
    :controller => SimulateDSController.new(0.01),
    :mino_factory => Mino::World,
    :pattern => "c",
    :field => <<-EOT,
    ......r.r.
    ......r.r.
    ......r.r.
    ......r.r.
      EOT
    :input => cyan_r_control,
  },
  {
    :title => "水色の軸補正 7の列にぶつかって0の列にもぶつかって、信じられないことに8の列をみずに、0の列の上に立つ",
    :controller => SimulateDSController.new(0.01),
    :mino_factory => Mino::World,
    :pattern => "c",
    :field => <<-EOT,
    ......r.rr
    ......r.rr
    ......r.rr
    ......r.rr
      EOT
    :input => cyan_r_control,
  },
  # --------------------------------------------------------------------------------
  {
    :title => "水色の軸補正 8の列にぶつかって、7の列に入る",
    :controller => SimulateDSController.new(0.01),
    :mino_factory => Mino::World,
    :pattern => "c",
    :field => <<-EOT,
    .......r..
    .......r..
    .......r..
    .......r..
      EOT
    :input => cyan_l_control,
  },
  {
    :title => "水色の軸補正 8,7とぶつかって、信じられないことに、10の列に入る",
    :controller => SimulateDSController.new(0.01),
    :mino_factory => Mino::World,
    :pattern => "c",
    :field => <<-EOT,
    ......rr..
    ......rr..
    ......rr..
    ......rr..
      EOT
    :input => cyan_l_control,
  },
]

# Simulator.start(library[0], 60)
# exit;

if $0 == __FILE__
#   library.each{|e| Simulator.start_auto(e, 60) == :break and break}
#   exit
  if ARGV.empty?
    Simulator.start_auto(library.reverse.find{|e|!e[:input].nil?}, 60)
  else
    Simulator.start(library.reverse.find{|e|!e[:input].nil?}, 60)
  end
  Simulator.start_auto(library[0],60)
end

library
