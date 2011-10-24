# テトリス消しから開始する連続消しコンボを調べる
module ComboController
  def initialize
    super
    @combo_state = State.new(:idol)
  end

  def non_line_clear_signal
    super
    @combo_state.transition(:idol)
  end

  def lines_clear_signal(player)
    super
    @combo_state.transition_safe do
      case @combo_state.state
      when :idol
        if player.field.complate_info.size >= 4
          @combo_state.transition!(:active)
        end
      when :active
        combo_signal(@combo_state.count)
      end
    end
  end

  def combo_signal(count)
  end
end
