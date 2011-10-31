#!/usr/local/bin/ruby -Ku
require "environment"
frame = Modes::FrameMaster20GNoIRS.new
UI::DrawAll.new(frame)
frame.start(60)
