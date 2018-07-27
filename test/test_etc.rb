require "test_helper"

class TestEtc < Test::Unit::TestCase
  test "all" do
    assert { Stylet::Chore.clamp(0.5) == 0.5 }

    assert { Stylet::Chore.clamp(0.5) == 0.5 }
    assert { Stylet::Chore.max_clamp(1.5) == 1.0 }
    assert { Stylet::Chore.min_clamp(-0.5) == 0.0 }
    assert { Stylet::Chore.abs_clamp(-1.5) == -1.0 }

    assert { Stylet::Chore.shortest_angular_difference(0.2, 0.8).round(3) == 0.4 }
    assert { Stylet::Chore.shortest_angular_difference(0.3, 0.8).round(3) == -0.5 }
    assert { Stylet::Chore.shortest_angular_difference(0.4, 0.8).round(3) == -0.4 }
  end
end
