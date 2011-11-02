# -*- coding: utf-8 -*-

# 引数で与えられたフィールドを表示する

require "delegate"

require File.expand_path(File.join(File.dirname(__FILE__), "../config"))
require File.expand_path(File.join(File.dirname(__FILE__), "sdl/draw"))
require File.expand_path(File.join(File.dirname(__FILE__), "../vsync"))

# 将来、delegateとして上位クラスを動的に切り替えるかもしれないので draw_begin/draw_endなどを継承するように書いてはならない。
# というより、重要なのは update だけなので、draw_begin などは普通に @obj.draw_begin の形にする方がいいのかな。
# FieldDisplayAbstractModule
module UI
  class DrawField < SimpleDelegator
    attr_accessor :edge

    def initialize(target)
      super(Sdl::Draw.instance)
      target.add_observer(self)
      @margin = 45
      @y_center = 0

      @edge = CONFIG[:edge]              # 縁取りするか? nil=しない :INSIDE=内側 :OUTSIDE=外側
    end

    # 連絡が来たら常に描画する
    def update(*args)
      draw(*args)
    end

    # 描画
    def draw(*args)
      polling
      draw_begin
      bg_clear
      gprint(0, 0, system_line)
      draw_main(*args)            # ここだけを積極的に継承させる
      self.count += 1
      draw_end
    end

    # *args = field と仮定。
    def draw_main(field)
      set_draw_point(field, 0, 1)
      display_field(field)
      draw_mino_frame_line(field)
      display_field_frame(field)
    end

    ################################################################################

    # 基準点とシンボルの対応
    #
    #   lt    ct    rt
    #    +----------+
    #    |          |
    # lt2+----------+rt2
    #    |          |
    #    |          |
    #    |          |
    #    |          |
    #    +----------+
    #   lb    cb    rb
    #
    def set_draw_point(field, index, num)

      # w, h = 仮想フィールド幅
      w = field.width  * get_wsize
      h = field.height * get_hsize

      # 不可視領域の高さ
      a = Field::INVISIBLE_AREA * get_hsize

      sw = width - @margin * 2    # マージンを省いた画面幅
      @local_width = sw / num     # 一つのフィールドが使用可能な最大幅

      # フィールド不可視部分の左上角
      x = @margin + (@local_width * index) + (@local_width / 2) - (w / 2)
      x -= get_slide(num)         # フィルードを中央から左にずらす
      y = height / 2 - h / 2 + @y_center

      # 各基準点の計算
      @basic_points = {
        :lt  => [x,     y  ],
        :rt  => [x+w,   y  ],
        :lb  => [x,     y+h],
        :rb  => [x+w,   y+h],
        :cb  => [x+w/2, y+h],
        :lt2 => [x,     y+a],
        :rt2 => [x+w,   y+a],
        :ct2 => [x+w/2, y+a],
      }
    end

    # 中心をずらすのはフィールドが二つ以上表示されるときだけにする。
    # ずらす量はフィールド幅の半分
    def get_slide(num)
      if num >= 2
        @local_width * 0.15
      else
        0
      end
    end

    def get_locate(sym)
      @basic_points[sym]
    end

    def get_wsize
      CONFIG[:mino_size][0]
    end

    def get_hsize
      CONFIG[:mino_size][1]
    end

    def grid_main(fields)
      return unless $DEBUG

      # 画面真中の水平線
      draw_line(0, height/2, width, height/2, "g")

      # 各フィールドが持つ最大幅の幅を縦線で書く
      fields.size.succ.times{|i|
        x = @margin + @local_width * i
        draw_line(x, 0, x, height, "g")
      }
    end

    def relative_gprint(base, x, y, str)
      tx, ty = get_locate(base)
      gprint(tx+x, ty+y, str)
    end

    ################################################################################

    # 指定したブロックオブジェクトの表示
    def display_mino(field, mino)
      return unless mino
      tx, ty = get_locate(:lt)
      mino.get_points.each {|po|
        x0 = tx + (mino.pos.x + po.x) * get_wsize
        y0 = ty + (mino.pos.y + po.y) * get_hsize
        # p mino.view_color
        fill_rect(x0, y0, get_wsize, get_hsize, mino.view_color)
      }
    end

    # フィールドの表示
    def display_field(field)
      # 既存セル表示
      bx, by = get_locate(:lt)
      (Field::INVISIBLE_AREA...field.height).each {|y|
        field.width.times {|x|
          cell = field.get(x, y)
          next unless cell.seen?
          # p cell.color
          fill_rect(
                    bx + x * get_wsize,
                    by + y * get_hsize,
                    get_wsize, get_hsize,
                    "dark_" + cell.color)
        }
      }
    end

    # フィールド回り表示
    def display_field_frame(field)
      # 枠
      bx, by = get_locate(:lt2)
      draw_rect(
                bx - 1,
                by - 1,
                get_wsize * field.width   + 1,
                get_hsize * field.height2 + 1,
                "frame")

      # 上枠の表示
      bx, by = get_locate(:lt)
      draw_rect(
                bx - 1,
                by - 1,
                get_wsize * field.width  + 1,
                get_hsize * field.height + 1,
                "frame") if $DEBUG
    end

    def draw_mino_frame_line(field)
      return unless @edge

      bx, by = get_locate(:lt)

      # 縦のライン
      (Field::INVISIBLE_AREA..field.bottom).each {|y|
        prev = false
        (field.width+1).times{|x|
          cell = field.get(x, y)
          gap = nil
          if cell && cell.exist?
            if prev == false
              # 空白 -> ブロック
              gap = (@edge == :INSIDE) ? 0 : -1
            end
          else
            if prev
              # ブロック -> 空白
              gap = (@edge == :INSIDE) ? -1 : 0
            end
          end
          if gap
            sx = bx + x * get_wsize + gap
            sy = by + y * get_hsize
            ex = sx
            ey = by + (y+1) * get_hsize - 1
            draw_line(sx, sy, ex, ey, "edge")
          end
          prev = cell && cell.exist?
        }
      }

      # 横のライン
      field.width.times{|x|
        prev = false
        (field.height+1).times {|y|
          cell = field.get(x, y)
          # 一番下の淵と上の淵は描画しないようにのif文
          if Field::INVISIBLE_AREA < y
            gap = nil
            if cell && cell.exist?
              if prev == false
                # 空->ブロック
                gap = (@edge == :INSIDE) ? 0 : -1
              end
            else
              if prev
                # ブロック->空
                gap = (@edge == :INSIDE) ? -1 : 0
              end
            end
            if gap
              sx = bx + x * get_wsize
              sy = by + y * get_hsize + gap
              ex = bx + (x+1) * get_wsize - 1
              if true           # 1ドットの補正を行うか?
                if @edge == :INSIDE
                  # 90度曲る線の角を繋ぐために補正した側のブロックの左もしくは右のブロックがあればその方向に1ドットのばして引く
                  sx -= 1 if field.get(x-1, y+gap) && field.get(x-1, y+gap).exist?
                  ex += 1 if field.get(x+1, y+gap) && field.get(x+1, y+gap).exist?
                else
                  # 外に引く場合は、広げる時と短くする場合がある
                  sx += (!field.get(x-1, y+gap) || !field.exist?(x-1, y+gap)) ? -1 : +1
                  ex += (!field.get(x+1, y+gap) || !field.exist?(x+1, y+gap)) ? +1 : -1
                end
              end
              draw_line(sx, sy, ex, sy, "edge")
            end
          end
          prev = cell && cell.exist?
        }
      }
    end
  end

  # 互換性用

  class SdlField < DrawField
    def initialize(target, fps=nil)
      super(target, Sdl::Draw.instance)
    end
  end

end

if $0 == __FILE__
  require "backtrack"
  backtrack = BackTrack.new("cybrmg", 10, 22, true)
  UI::DrawField.new(backtrack)
  catch (:exit) {
    backtrack.backtrack
  }
  backtrack.display
end
