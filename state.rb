# 状態遷移管理

class State
  attr_reader :count, :state

  def initialize(state = nil)
    transition(state)
  end

  # FIXME: このメソッドは大丈夫か？
  def equal?(state)
    @state == state
  end

  def start?
    @count == 0
  end

  def pass
    @count += 1
  end

  def count_at?(count)
    @count == count
  end

  # 状態遷移
  def transition(state)
    @state = state
    @count = 0
  end

  def to_s
    "#{@state}: #{@count}"
  end

  # 一気に次の状態に移行する
  def transition!(state)
    transition(state)
    throw :transit
  end

  # transition! を使って瞬時に別の状態に移行するためのブロックを作る
  #
  # Example:
  #
  #   object = State.new(:idol)
  #   object.transition_safe do
  #     case object.state
  #     when :idol
  #       if object.count_at?(1)
  #         object.transition!(:active)
  #       end
  #     when :active
  #       if object.start?
  #       end
  #       if object.count_at?(1)
  #       end
  #     end
  #   end
  #
  def transition_safe(&pblock)
    begin
      ret = catch(:transit) {
        yield
        true
      }
    end until ret == true
    pass
  end
end
