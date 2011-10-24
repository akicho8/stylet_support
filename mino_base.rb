# FIXME: そのまま拡張しないようにする
module Mino
  class Base
    RotateKeys = [
      Direction::TURN_LEFT,
      Direction::TURN_RIGHT,
      Direction::TURN_LEFT,
      Direction::TURN_RIGHT,
    ]

    def init_for_play(column)
      @mino_gravity = 0.0
      @mino_state = :FALL_OK
      @lock_count = 0
      @column = column
      speed(0.2)
    end

    def controller_set(controller)
      @controller = controller
    end

    def speed(spd)
      @curspeed = spd
    end

    def next_position_set(column = @column)
      set_pos(Point.new(column, Field::INVISIBLE_AREA-3))
    end

    def start_position_set(column = @column)
      set_pos(Point.new(column, Field::INVISIBLE_AREA))
    end

    def view_color
      return "flash" if @flash_mode
      color                  # 注意。継承ではないので super ではダメ。
    end

    def flash(flag)
      @flash_mode = flag
    end

    def user_irs(input)
      # 最優先度のボタンオブジェクトとその番号を取得
      prio_key = input.get_button_array.sort.first
      if prio_key.press?
        if @controller.irs_enable && rotate!(RotateKeys[input.get_button_array.index(prio_key)])
          @controller.user_irs_success_signal(self) # IRSが成功したときに呼ぶ
        end
      end
      input.after_user_irs(self) # IRSの成功したかどうかには関係がない
      prio_key.press?
    end

    # プレイヤーによるブロック回転操作
    def user_rotate(input)
      input.get_button_array.each_with_index do |key, index|
        if key.trigger?
          dir = RotateKeys[index]
          success = rotate_with_correct!(dir)
          @controller.rotate_after_signal(self, dir, success)
        end
      end
    end

    # プレイヤーによる操作
    def user_controll(input, locktime)
      # 回転
      user_rotate(input)

      # 左右
      key = InputUtils.preference_key(input.axis.left, input.axis.right)
      dir = nil
      if key && key.repeat(@controller.power_delay) >= 1
        dir = (key == input.axis.right ? Point::RIGHT : Point::LEFT)
        input.power_key_filled(key)
      end
      if dir
        if move(dir)
          # ここの処理はコントローラ内の方がいいかも
          @controller.right_left_move_after_signal(self, dir)
        end
      end

      # ここで空に浮いているかもしれないので一旦状態を保存
      grounding_flag = grounding?

      # 上下
      key = InputUtils::preference_key(input.axis.down, input.axis.up) # 同時押しは下優先
      if key == input.axis.up
        unless dir
          hard_drop
        end
      elsif key == input.axis.down
        if move
          @controller.mino_down
        end
      end

      mino_auto_fall

      # 空に浮いた状態から接着状態になったため「下衝突」
      if !grounding_flag && grounding?
        @controller.fall_collision_signal
      end

      input.after_move(self, dir)

      return mino_adhesion_check(input, locktime) # 戻り値あり
    end

    def mino_auto_fall
      @mino_gravity += @curspeed
      @mino_gravity.to_i.times {
        if move
        else
          break
        end
      }
      @mino_gravity -= @mino_gravity.to_i
    end

    def mino_adhesion_check(input, locktime)
      if under_fall?
        if @mino_state == :FALL_STOP
          @mino_state = :FALL_OK
          @lock_count = 0
        end
      else
        if @mino_state == :FALL_OK
          @mino_state = :FALL_STOP
          @lock_count = 0
        end
      end
      if @mino_state == :FALL_STOP
        if @lock_count == 0
          @controller.collision_signal(self)
        end
        if (@controller.down_put && input.axis.down.count >= 1) || (@controller.up_put && input.axis.up.count >= 1)
          @controller.intent_lock_signal(self)
          true
        elsif locktime && (@lock_count == locktime)
          @controller.auto_lock_signal(self)
          true
        else
          @lock_count += 1
          false
        end
      else
        false
      end
    end

    def max_velocity?
      @curspeed >= @field.height2
    end

    # プレイヤーによる瞬時の落下(先行入力)
    def hard_drop_check(input)
      return unless input.axis.up.press?
      hard_drop
    end

    # プレイヤーによる意図的な即落下
    def hard_drop
      return unless @controller.immfall_enable
      dash{@controller.immediate_fall_signal}
      after_hard_drop
    end

    # ハードドロップ後の処理
    def after_hard_drop
    end
  end

  # Worldルール = IRSなし というわけではないので World クラスに対して user_irs を解除してはいけない
  # また after_user_irs フックもあるので解除してはいけない
  module World
    class Base
      def user_irs(*)
        super
      end
    end
  end
end
