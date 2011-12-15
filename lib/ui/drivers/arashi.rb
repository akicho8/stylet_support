class UI::Arashi < UI::JoyBase
  def lever_on?(dir)
    case dir
    when :up
      @object.button(4)
    when :right
      @object.button(5)
    when :down
      @object.button(6)
    when :left
      @object.button(7)
    else
      false
    end
  end
end
