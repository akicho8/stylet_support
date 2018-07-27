require "test_helper"

class TestEtc < Test::Unit::TestCase
  test "all" do
    # assert { Stylet::Etc.clamp(0.5) == 0.5 }

    assert_equal(0.5, Stylet::Etc.clamp(0.5))
    assert_equal(1.0, Stylet::Etc.max_clamp(1.5))
    assert_equal(0.0, Stylet::Etc.min_clamp(-0.5))
    assert_equal(-1.0, Stylet::Etc.abs_clamp(-1.5))

    assert_equal(0.4, Stylet::Etc.shortest_angular_difference(0.2, 0.8).round(3))
    assert_equal(-0.5, Stylet::Etc.shortest_angular_difference(0.3, 0.8).round(3))
    assert_equal(-0.4, Stylet::Etc.shortest_angular_difference(0.4, 0.8).round(3))
  end
end
