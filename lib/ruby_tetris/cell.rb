class Cell
  attr_reader :color

  # セルの生成
  #   cell = Cell.new("blue")
  #   cell2 = Cell.new(cell)
  def initialize(color = nil)
    @color = nil                # セルの種類
    @flag = false               # セルは有効?
    set(color) if color
  end

  # 有効化
  def set(color)
    if color.kind_of? Cell
      @color = color.color
      @flag = color.exist?
    else
      @color = color      # 文字列での指定では常に存在することにする
      @flag = true
    end
  end

  # 無効化
  def clear!
    @flag = false
  end

  # 存在する?
  def exist?
    @flag
  end

  # 文字列表現
  def to_s
    @flag ? @color[0..0].downcase : "."
  end

  def ==(other)
    return false if !other.respond_to?(:exist?) || !other.respond_to?(:color)
    exist? == other.exist? && color == other.color
  end
end
