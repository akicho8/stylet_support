module UI
  module Color
    Palette = {
      # フィールドのセルに指定できる色
      "yellow" => [255, 255,   0],
      "blue"   => [  0,   0, 255],
      "orange" => [255, 127,   0],
      "green"  => [127, 255,   0],
      "purple" => [255,   0, 255],
      "cyan"   => [  0, 255, 255],
      "red"    => [255,   0,   0],
      "x"      => [127, 127, 127], # お邪魔ブロック
      "*"      => [160, 127, 127], # 特別な色

      # フィールドの枠などの色
      "flash" => [255, 255, 255],
      "frame" => [255, 255, 255],
      "bg"    => [  0,   0,   0],
      "font"  => [ 80, 160, 255],
      "edge"  => [8*24, 8*24, 8*24],
    }

    # フィールドのセルに指定できる色の暗いバージョンや1文字版の作成
    %w(yellow blue orange green purple cyan red x).each do |color|
      values = Palette[color]
      one_char = color.scan(/./).first.downcase
      light_color = values.collect{|v|[0, v - 16].max}
      dark_color  = values.collect{|v|[0, v - 64].max}
      # 1文字版
      Palette.update({
          "#{color}"         => light_color,
          "#{one_char}"      => light_color,
          "dark_#{one_char}" => dark_color,
          "dark_#{color}"    => dark_color,
        })
    end
  end
end
