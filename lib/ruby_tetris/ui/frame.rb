# -*- coding: utf-8 -*-
# TGM依存の表示関連

require File.expand_path(File.join(File.dirname(__FILE__), "field"))
require File.expand_path(File.join(File.dirname(__FILE__), "sdl/input"))

# Linuxかつ /dev/input/js0 等が使えるときだけ用
#
# フィールド表示クラス元にフレーム表示クラスを作成
module UI
  class DrawFrame < DrawField
    def initialize(target)
      super
      set_title(target.players.first.controller.mode_name)
      # set_title(target::Name)
    end

    def draw_main(frame)
      # フィールドを順番に表示していく
      frame.fields.each_with_index {|field,i|
        set_draw_point(field, i, frame.fields.size)
        display_field(field)

        # 現在のフィールドに所属しているプレイヤーを調べる。
        players = frame.players.select{|pl|pl.field.object_id == field.object_id}

        # 現在のフィールドに所属しているプレイヤーの誰かが life_count.nil? であれば edge を表示する。
        draw_mino_frame_line(field) if players.find{|pl|pl.controller.life_count.nil?}

        # 枠表示
        display_field_frame(field)

        # 現在のフィールドに所属しているプレイヤーを探してブロックを描画する
        players = frame.players.select{|pl|pl.field.object_id == field.object_id}
        players.each{|pl|
          display_mino(pl.field, pl.current_mino)
          display_mino(pl.field, pl.next_mino)
        }

        # 現在のフィールドに所属している先頭のプレイヤーのレベル情報を表示する。
        # フィールドが複数ある場合にここが重なってしまう。画面の大きさを変えれば
        # 重ならないのでこれでいいことにする。
        if respond_to?(:level_disp)
          level_disp(players.first)
        end
      }
      grid_main(frame.fields)
    end
  end

  # TGM依存の表示クラス
  class DrawAll < DrawFrame
    def level_disp(player)
      controller = player.controller
      # relative_gprint(:lt, -20, 0, controller.mode_name)
      if controller.respond_to?(:grade_name)
        relative_gprint(:rt, 6, 8, controller.grade_name)
      end
      if controller.respond_to?(:score_count)
        relative_gprint(:rb, 6, -62+6, "SCORE")
        relative_gprint(:rb, 6, -50+6, controller.score_count)
      end
      if controller.respond_to?(:level_count)
        relative_gprint(:rb, 6, -32+6, "LEVEL")
        relative_gprint(:rb, 6, -20+6, controller.level_count)
      end
      if controller.respond_to?(:time_count)
        relative_gprint(:cb, -6*4, 3, controller.time_count)
      end
    end

    # private
    # def relative_gprint(base, x, y, str)
    #   tx, ty = get_locate(base)
    #   gprint(tx+x, ty+y, str)
    # end

  end

  # トレーニングモード用
  class SimulateFrameDraw < DrawFrame
    def draw_main(frame)
      super
      # controller = frame.players.first.controller
      # gprint(0, 32, "<#{controller.mode_name}>")
      # gprint(0, 64, "<#{frame.simulator_params[:title]}>")
      # gprint(0, 64, frame.simulator_params[:title])

      # relative_gprint(:cb, -6*2, 3, "%3d" % frame.simulator_params[:title].to_i)

      if frame.respond_to?(:simulator_params)
        relative_gprint(:lt2, -8*6, 8*0.5, "%3d" % frame.simulator_params[:title].to_i)
      end
    end

    # def system_line
    # end
  end

  # TGM依存の表示クラス(に画面のスナップショットを取る機能付き)
  class DrawAllWithSnapShot < DrawAll
    attr_accessor :snapdir

    def draw_main(*args)
      super
      save_bmp(File.join(@snapdir, ("%06d" % [@count]) + ".bmp"))
    end

    def system_line
      "#{@count}"
    end
  end
end

if $0 == __FILE__
  require "tap_vs_doubles_mode"
  require "tap_vs_mode"

  frame = Modes::FrameDoublesVersus.new
  frame = Modes::FrameVersus.new
  UI::DrawAll.new(frame)
  frame.start(60)
end
