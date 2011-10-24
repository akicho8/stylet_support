#!/usr/local/bin/ruby -Ku
require "environment"
frame = Modes::FrameDeath.new
UI::DrawAll.new(frame)
frame.start(60)
