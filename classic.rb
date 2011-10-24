# クラシックルール

module Mino
  module Classic
    class Base < Mino::Base
    end

    class Yellow < Base
      @color = "yellow"
      @jcolor = "黄"
      @shape = parse_string(<<-EOS)
    ....
      .oo.
      .oo.
      ....
      EOS
      def self.first_appear?
        false
      end
    end

    # 青と橙が下向きでかつ、◎の位置にブロックがあると、回転できないようにする。
    #
    #     下       右       上       左
    #     -------- --------- ------- --------
    #  青 □□□□ □■□□ □□□□ □■■□
    #     ■■■□ □■□□ ■△□□ □■□□
    #     □◎■□ ■■□□ ■■■□ □■□□
    #     □□□□ □□□□ □□□□ □□□□
    #
    #  橙 □□□□ ■■□□ □□□□ □■□□
    #     ■■■□ □■□□ □△■□ □■□□
    #     ■◎□□ □■□□ ■■■□ □■■□
    #     □□□□ □□□□ □□□□ □□□□
    #
    module Block_Part_Blue_Orange
      def rotate_with_correct!(turn=Direction::TURN_LEFT)
        weak_points = {}
        weak_points[Point::DOWN] = [0, 1]
        weak_points[Point::UP]   = [0, 0] if true # ここを有効にすると△の部分にブロックがあっても回転できなくなる。
        weak_point = weak_points[@dir.to_i]
        if weak_point
          x, y = weak_point
          if @field.get(@pos.x + x, @pos.y + y).exist?
            return false
          end
        end
        super
      end
    end

    class Blue < Base
      include Block_Part_Blue_Orange
      @color = "blue"
      @jcolor = "青"
      @shape = parse_string(<<-EOS)
    ....
      ooo.
      ..o.
      ....
      ----
      .o..
      .o..
      oo..
      ....
      ----
      ....
      o...
      ooo.
      ....
      ----
      .oo.
      .o..
      .o..
      ....
      EOS
    end

    class Orange < Base
      include Block_Part_Blue_Orange
      @color = "orange"
      @jcolor = "橙"
      @shape = parse_string(<<-EOS)
    ....
      ooo.
      o...
      ....
      ----
      oo..
      .o..
      .o..
      ....
      ----
      ....
      ..o.
      ooo.
      ....
      ----
      .o..
      .o..
      .oo.
      ....
      EOS
    end

    class Green < Base
      @color = "green"
      @jcolor = "緑"
      @shape = parse_string(<<-EOS)
    ....
      oo..
      .oo.
      ....
      ----
      ..o.
      .oo.
      .o..
      ....
      EOS
      def self.first_appear?
        false
      end
    end

    class Purple < Base
      @color = "purple"
      @jcolor = "紫"
      @shape = parse_string(<<-EOS)
      ....
      .oo.
      oo..
      ....
      ----
      o...
      oo..
      .o..
      ....
      EOS
      def self.first_appear?
        false
      end
    end

    class Cyan < Base
      @color = "cyan"
      @jcolor = "水"
      @shape = parse_string(<<-EOS)
      ....
      ooo.
      .o..
      ....
      ----
      .o..
      oo..
      .o..
      ....
      ----
      ....
      .o..
      ooo.
      ....
      ----
      .o..
      .oo.
      .o..
      ....
      EOS
    end

    class Red < Base
      @color = "red"
      @jcolor = "赤"
      @shape = parse_string(<<-EOS)
    ....
      oooo
    ....
      ....
      ----
      ..o.
      ..o.
      ..o.
      ..o.
      EOS
      def rotate_with_correct!(turn=Direction::TURN_LEFT)
        rotate!(turn)
      end
    end

    module_function

    def list
      [Yellow, Blue, Orange, Green, Purple, Cyan, Red]
    end

    # no = 0 or "yellow" or "y" or "黄色" or "黄"
    def create(color)
      list[color_to_mino_index(color)].new
    end

    # ブロックの一辺の最大サイズを取得
    def mino_size_max
      list.collect{|c|c.range_vicinity}.max
    end

    # ブロックの一辺の最大サイズで正方形の幅オブジェクトを返す
    def field_area
      Field::Area.new([mino_size_max, mino_size_max])
    end

    # ブロック文字を表す集合文字列を得る(文字列の配列で返す)
    # [01234567]
    def validity_index_colors
      Range.new("0", list.size.to_s, true).to_a
    end

    # [ybogpcr]
    def validity_alpha_colors
      list.collect{|klass|klass.color.scan(/./).first.downcase}
    end
    # [黄青橙緑紫水赤]
    def validity_kanji_colors
      list.collect{|klass|klass.jcolor}
    end

    # "yellow" => 0
    # "黄色" => 0
    # "0" => 0
    # 0 => 0
    def color_to_mino_index(color)
      color = color.to_s.scan(/./).first.downcase # color[0..0]では全角文字列の先頭文字を取り出してくれない
      validity_alpha_colors.index(color) || validity_index_colors.index(color) || validity_kanji_colors.index(color)
    end

    # "黄b2"=> [0,1,2]
    def pattern_to_index_str_pattern(pattern)
      pattern.to_s.scan(/./).collect{|c|color_to_mino_index(c)}.compact.to_s
    end

    # "黄b2" => "ybo"
    def pattern_to_alpha_str_pattern(pattern)
      str = pattern_to_index_str_pattern(pattern)
      str.tr(validity_index_colors.to_s, validity_alpha_colors.to_s)
    end

    # "黄b2" => "黄青橙"
    def pattern_to_kanji_str_pattern(pattern)
      str = pattern_to_index_str_pattern(pattern)
      str.tr(validity_index_colors.to_s, validity_kanji_colors.to_s)
    end
  end
end
