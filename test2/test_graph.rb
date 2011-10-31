require "test/unit"

$LOAD_PATH << ".."
require "graph"
require "tap_master_mode"

class TestGraph < Test::Unit::TestCase
  def test_graph
    frame = Modes::FrameMaster.new
    UI::DrawAll.new(frame)
    frame.next_frame
    frame.save_direct_info
    rec = RecFile.new(frame.to_marshal_binary)

    Graph::GraphSection.new(rec).view
    sleep(1)

    Graph::GraphBlock.new(rec).view
    sleep(1)
  end
end
