require File.expand_path(File.join(File.dirname(__FILE__), "environment"))
frame = Modes::FrameDeath.new
UI::DrawAll.new(frame)
frame.start(60)
