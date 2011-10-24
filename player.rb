# プレイヤー。ここを汎用化して拡張可能にする。
class Player
  attr_accessor :input
  attr_reader :state, :pattern, :controller
  attr_reader :field, :current_mino, :next_mino
  attr_reader :column

  def initialize(field, column, input, pattern, controller, mino_factory=nil)
    @field = field
    @column = column
    @input = input
    @pattern = pattern
    @controller = controller
    @mino_factory = mino_factory || Mino::Classic
    @state = State.new(:ready_go_state)
    @current_mino = nil
    @next_mino = get_next_mino
  end

  def get_next_mino
    no = @pattern.get_next2
    return nil if no.nil?
    mino = @mino_factory.create(no)
    mino.init_for_play(@column)
    mino.speed(@controller.speed)
    mino.attach(@field)
    mino.next_position_set
    mino.controller_set(@controller)
    mino
  end

  def puton
    @current_mino.puton if @current_mino
  end

  def putoff
    @current_mino.putoff if @current_mino
  end

  # FIXME: この長いメソッドをどうにかする
  def next_frame
    @input.next_frame(self)
    @state.transition_safe do
      case @state.state
      when :ready_go_state      # 最初に待つ
        if @state.start?
          @controller.ready_go_signal(self)
          @input.think_first(self)
        end
        if @state.count_at?(@controller.start_delay-1)
          @controller.start_signal(self)
          @state.transition! :tetrimino_set_state
        end
      when :tetrimino_set_state        # ブロックのセット
        if @state.start?
          if @next_mino.nil? # ブロックが無くなっていたら例外
            throw :exit, :lost_mino
          end
          @current_mino = @next_mino
          @current_mino.start_position_set

          @next_mino = get_next_mino

          @controller.mino_set_signal(self)

          unless @current_mino.place?
            @state.transition! :end_state
          end

          if @current_mino.user_irs(@input)
            @controller.irs_signal(self)
          end
          if @current_mino.max_velocity? # 20Gなら先に落す
            @current_mino.fall
            @controller.max_velocity_fall_collision_signal
          end
          @current_mino.hard_drop_check(@input) # 上入れ落下(先行入力)
        end
        if @state.count_at?(1)
          @state.transition! :move_state
        end
      when :move_state       # 操作している状態
        if @state.start?
          @controller.move_before_signal
        end
        if @current_mino.user_controll(@input, @controller.level_info.lock_delay)
          @state.transition! :flash_state
        end
      when :flash_state      # 白く光る状態
        if @state.start?
          @current_mino.flash(true)
          @controller.lock_signal(self)
        end
        if @state.count_at?(@controller.level_info.flash_delay)
          @controller.before_puton_signal(self)
          if @controller.level_info.fall_delay # fall_delay.nil? なら置けないことにする
            @current_mino.puton(@controller.life_count)
          end
          @current_mino = nil
          @controller.signal_after_puton_signal(self)
          @input.think_first(self)

          @complate_info = @field.complate_info
          if @complate_info.size >= 1
            @state.transition! :clear_state
          end
          @controller.non_line_clear_signal
          @state.transition! :puton_state
        end
      when :puton_state      # 置いて暫くまつ
        if @state.start?
        end
        if @state.count_at?(@controller.level_info.next_delay)
          @state.transition! :block_up_prev_state
        end
      when :clear_state      # ブロックをクリアした状態
        if @state.start?
          info = @field.complate_info
          @controller.lines_clear_signal(self)
          @field._clear_lines(info)
        end
        if @state.count_at?(@controller.level_info.fall_delay) # クリアした状態で待つ
          if @field.get_top < @complate_info.min # 消した時に上にブロックが存在する
            @controller.signal_field_down_signal(self)
          end
          @field.reject_lines(@complate_info)
          @controller.lines_reject_after_signal(self)
          @state.transition! :cdelay_state
        end
      when :cdelay_state     # ブロックを消してブロックが落ちた後の待ち
        if @state.start?
        end
        if @state.count_at?(@controller.level_info.next_delay2)
          @state.transition! :block_up_prev_state
        end
      when :block_up_prev_state # <= [[cdelay_state <= clear_state] or [puton_state]] <= flash_state
        if @state.start?
          @state.transition! :block_up_state
        end
      when :block_up_state      # ?
        if @state.start?
          @controller.block_up_call_signal(field)
        end
        unless @controller.updata.empty?
          @field.rise_line(@controller.updata.shift)
        end
        if @controller.updata.empty?
          @state.transition! :tetrimino_set_state
        end
      when :end_state        # ゲームオーバー時
        if @state.start?
          @controller.game_over_start_signal(self)
        end
        if @state.count_at?(@controller.end_delay)
          throw :exit, :gameover
        end
      else
        raise ArgumentError, "unknown state: #{@state}"
      end
    end
    @controller.pass
  end
end
