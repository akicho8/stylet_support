require "test_helper"

class TestEtc < Test::Unit::TestCase
  test "all" do
    assert { Stylet::Etc.clamp(0.5) == 0.5 }

    assert { Stylet::Etc.clamp(0.5) == 0.5 }
    assert { Stylet::Etc.max_clamp(1.5) == 1.0 }
    assert { Stylet::Etc.min_clamp(-0.5) == 0.0 }
    assert { Stylet::Etc.abs_clamp(-1.5) == -1.0 }

    assert { Stylet::Etc.shortest_angular_difference(0.2, 0.8).round(3) == 0.4 }
    assert { Stylet::Etc.shortest_angular_difference(0.3, 0.8).round(3) == -0.5 }
    assert { Stylet::Etc.shortest_angular_difference(0.4, 0.8).round(3) == -0.4 }
  end
end
