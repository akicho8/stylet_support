class Stylet::ElecomUsbPadAdapter < Stylet::JoystickAdapter
  def h_axis_index
    3
  end

  def v_axis_index
    4
  end

  def button_on?(key)
    pos = {
      :btA => 0,
      :btB => 1,
      :btC => 3,
      :btD => 2,
    }[key]
    if pos
      @object.button(pos)
    end
  end
end
