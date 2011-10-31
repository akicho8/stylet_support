# Extendモード対応セル

class LifeCell < Cell
  def initialize(*args)
    super
    @life_count = nil
  end

  # FIXME: きっと他の書き方があるはず。instance_exec 等を使うこと
  def replace(other)
    instance_variables.each do |var|
      eval %[
        #{var} = other.instance_eval("#{var}")
      ]
    end
  end

  def set(arg)
    super
    if arg.is_a? String
      @life_count = nil
    end
  end

  # 次の世代へ進む
  def next!
    if @life_count
      if @life_count > 0
        @life_count -= 1
      end
    end
  end

  # 見える？
  def seen?
    exist? && (@life_count.nil? || @life_count > 0)
  end

  def set_life_count(count)
    @life_count = count
  end

  # 強制的に表示
  def show!
    set_life_count(nil)
  end
end
