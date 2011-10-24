#!/usr/local/bin/ruby -Ku


require "test/unit"

$LOAD_PATH << ".."
require "ui/frame"
require "recfile"
require "tap_master_mode"

class TestRecFileSeg < Test::Unit::TestCase
  REC_FILE = "_tmp.rec"
  MPG_FILE = "_tmp.mpg"

  def setup

    frame = Modes::FrameMaster.new
    UI::DrawAll.new(frame)
    2.times{frame.next_frame}
    frame.save_direct_info
    open(REC_FILE, "w"){|f|f.write(frame.to_marshal_binary)}

    @obj = RecFile.open(REC_FILE)
  end

  def teardown
    File.delete(REC_FILE) if File.exist?(REC_FILE)
    File.delete(MPG_FILE) if File.exist?(MPG_FILE)
  end

  def test_to_strary_one
    assert_instance_of(Array, @obj.summary)
    assert_equal("MASTER", @obj.summary[0][0])
    assert_equal(REC_FILE, @obj.summary[0][-1])
    # p @obj.summary
  end

  def test_to_strary
    assert_instance_of(Array, @obj.sections)
    assert(2 <= @obj.sections.size)
    # @obj.sections.each{|e|p e}
  end

  def test_view_segment
    @obj.seginfo.each_index{|i|@obj.view_segment(i)}
  end

  def test_play_segment
    # @obj.seginfo.each_index{|i|@obj.play_segment(i, [Players::Player1])}
  end

  def test_replay_segment
    (1...@obj.seginfo.size).each{|i|@obj.replay_segment(i)}
  end

  def test_replay_first
    @obj.replay_first
  end

  def test_mpeg_convert
    assert_equal(true, @obj.mpeg_convert(MPG_FILE))
    assert_equal(true, Tool.mpeg_player(MPG_FILE))
  end

end
