$LOAD_PATH.unshift(File.expand_path(File.dirname(__FILE__) + "/.."))
require "test_helper"

class TestBackTrack < Test::Unit::TestCase
  # バックトラックの動作テスト
  def test_back_track
    # backtrack = BackTrack.new("162405361452016", 10, 20)
    # 積=1212 フィールド=4x10 全てのパターン探索=true
    backtrack = BackTrack.new("bobo", 4, 10, true)
    assert_instance_of(BackTrack, backtrack)
    backtrack.backtrack
    assert_equal(2, backtrack.result.size)
    assert_equal(4, backtrack.result[0].history.size)
    assert_equal("bobo", backtrack.result[0].history.collect{|v|v.color_char}.join(""))
    assert_equal(<<END, backtrack.result[0].to_s(:ustrip => true))
bboo
bboo
bboo
bboo
END
  end
  def test_back_track_fail
    backtrack = BackTrack.new("")
    backtrack.backtrack
    assert_equal(true, backtrack.result.empty?)
  end
  def test_back_track_lambda
    log = []
    backtrack = BackTrack.new("yy", 4, 10, false) {|field| log << field.clone}
    backtrack.backtrack
    assert_equal(true, backtrack.result==log)
  end
end
