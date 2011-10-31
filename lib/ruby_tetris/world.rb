# -*- coding: utf-8 -*-
# Worldルール

module Mino
  module World
    class Base < Mino::Base
      # 軸補正
      #
      # 特徴
      # ・軸がぶつかったとき、身近な左右を確認するのではなく、いきなり左に2カラム進んだところを確認している。
      # ・左右だけではなく上下にも軸移動する。
      #
      # |      cccc|    |          |  1. 9のカラムで軸がぶつかる
      # |      rrr | R  |      rrrc|  2. 0(+1)カラムに入る
      # |      rrr | => |      rrrc|
      # |      rrr |    |      rrrc|  ※次の例を見るとすぐに右隣りをみていないことがわかる。
      # |      rrr |    |      rrrc|
      # +----------+    +----------+
      #  1234567890      1234567890
      #
      # |      cccc|    |          |  1. 9のカラムで軸がぶつかる
      # |        r | R  |      c r |  2. 7(-2)のカラムに入る
      # |        r | => |      c r |
      # |        r |    |      c r |  これは補正というよりワープである。
      # |        r |    |      c r |
      # +----------+    +----------+
      #  1234567890      1234567890
      #
      # |      cccc|    |          |  1. 9のカラムで軸がぶつかる
      # |      r r | R  |      r rc|  2. 7(-2)のカラムで軸がぶつかる
      # |      r r | => |      r rc|  3. 0(+1)のカラムに入る
      # |      r r |    |      r rc|
      # |      r r |    |      r rc|
      # +----------+    +----------+
      #  1234567890      1234567890
      #
      # |cccc      |    |          |
      # | r        | L  |cr        |
      # | r        | => |cr        |
      # | r        |    |cr        |
      # | r        |    |cr        |
      # +----------+    +----------+
      #  1234567890      1234567890
      #
      # |cccc      |    |          |
      # |rr        | L  |rrc       |
      # |rr        | => |rrc       |
      # |rr        |    |rrc       |
      # |rr        |    |rrc       |
      # +----------+    +----------+
      #  1234567890      1234567890
      #
      # |cccc      |    |          |
      # |rrr       | L  |rrrc      |
      # |rrr       | => |rrrc      |
      # |rrr       |    |rrrc      |
      # |rrr       |    |rrrc      |
      # +----------+    +----------+
      #  1234567890      1234567890
      #
      # |          |    |   c      |
      # |          |    |   c      |
      # |          |    |   c      |
      # |cccc      |    |   c      |
      # |rrrr      | R  |rrrr      |
      # |rrrr      | => |rrrr      |
      # |rrrr      |    |rrrr      |
      # |rrrr      |    |rrrr      |
      # +----------+    +----------+
      #  1234567890      1234567890

      def rotate_with_correct!(turn=Direction::TURN_LEFT)
        if turn == Direction::TURN_RIGHT
          unless rotate!(turn)
            unless rotate!(turn, Point::LEFT, 2)
              unless rotate!(turn, Point::RIGHT)
                unless rotate!(turn, [+1, -2]) # 右上
                  return false
                end
              end
            end
          end
        else
          unless rotate!(turn)                      # 8
            unless rotate!(turn, Point::LEFT, 1)    # 7
              unless rotate!(turn, Point::RIGHT, 2) # 10
                unless rotate!(turn, [-1, -2])    # 7上 (左上)
                  return false
                end
              end
            end
          end
        end
        true
      end
    end

    class Yellow < Base
      @color = "yellow"
      @jcolor = "黄"
      @shape_char = "o"
      @shape = [
        Shape.new("symmetry", <<-EOT),
      ....
      .oo.
      .oo.
      ....
EOT
      ]
    end

    class Blue < Base
      @color = "blue"
      @jcolor = "青"
      @shape_char = "j"
      @shape = [
        Shape.new("right", <<-EOT),
      o...
      ooo.
      ....
      ....
EOT
        Shape.new("down", <<-EOT),
      .oo.
      .o..
      .o..
      ....
EOT
        Shape.new("left", <<-EOT),
      ....
      ooo.
      ..o.
      ....
EOT
        Shape.new("up", <<-EOT),
      .o..
      .o..
      oo..
      ....
EOT
      ]
    end

    class Orange < Base
      @color = "orange"
      @jcolor = "橙"
      @shape_char = "l"
      @shape = [
        Shape.new("left", <<-EOT),
      ..o.
      ooo.
      ....
      ....
EOT
        Shape.new("up", <<-EOT),
      .o..
      .o..
      .oo.
      ....
EOT
        Shape.new("right", <<-EOT),
      ....
      ooo.
      o...
      ....
EOT
        Shape.new("down", <<-EOT),
      oo..
      .o..
      .o..
      ....
EOT
      ]
    end

    class Red < Base
      @color = "red"
      @jcolor = "赤"
      @shape_char = "z"
      @shape = [
        Shape.new("flat", <<-EOT),
      oo..
      .oo.
      ....
EOT
        Shape.new("straight", <<-EOT),
      ..o.
      .oo.
      .o..
      ....
EOT
        Shape.new("flat", <<-EOT),
      ....
      oo..
      .oo.
      ....
EOT
        Shape.new("straight", <<-EOT),
      .o..
      oo..
      o...
      ....
EOT
      ]
    end

    class Green < Base
      @color = "green"
      @jcolor = "緑"
      @shape_char = "s"
      @shape = [
        Shape.new("flat", <<-EOT),
      .oo.
      oo..
      ....
EOT
        Shape.new("straight", <<-EOT),
      .o..
      .oo.
      ..o.
      ....
EOT
        Shape.new("flat", <<-EOT),
      ....
      .oo.
      oo..
      ....
EOT
        Shape.new("straight", <<-EOT),
      o...
      oo..
      .o..
      ....
EOT
      ]
    end

    class Purple < Base
      @color = "purple"
      @jcolor = "紫"
      @shape_char = "t"
      @shape = [
        Shape.new("up", <<-EOT),
      .o..
      ooo.
      ....
      ....
EOT
        Shape.new("right", <<-EOT),
      .o..
      .oo.
      .o..
      ....
EOT
        Shape.new("down", <<-EOT),
      ....
      ooo.
      .o..
      ....
EOT
        Shape.new("left", <<-EOT),
      .o..
      oo..
      .o..
      ....
EOT
      ]
    end

    class Cyan < Base
      @color = "cyan"
      @jcolor = "水"
      @shape_char = "i"
      @shape = [
        Shape.new("flat", <<-EOT),
      ....
      oooo
      ....
      ....
EOT
        Shape.new("straight", <<-EOT),
      ..o.
      ..o.
      ..o.
      ..o.
EOT
        Shape.new("flat", <<-EOT),
      ....
      ....
      oooo
      ....
EOT
        Shape.new("straight", <<-EOT),
      .o..
      .o..
      .o..
      .o..
EOT
      ]
    end

    include Classic
    def list
      [Yellow, Blue, Orange, Green, Purple, Cyan, Red]
    end

    module_function :list
    module_function :create
    module_function :mino_size_max
    module_function :field_area
    module_function :validity_index_colors
    module_function :validity_alpha_colors
    module_function :validity_kanji_colors
    module_function :color_to_mino_index
    module_function :pattern_to_index_str_pattern
    module_function :pattern_to_alpha_str_pattern
    module_function :pattern_to_kanji_str_pattern
  end
end

if $0 == __FILE__
  x = Mino::Classic::Yellow.new
  p x
  p Mino::Classic::Yellow.class_eval{@first_appear}
  p Mino.list
  p Mino.list.last.color
  p Mino::Classic.list
  p Mino::World.list
  p Mino::Classic.create(0)
  p Mino::World.create(0)
end
