# -*- coding: utf-8 -*-

class Stylet::ArashiAdapter < Stylet::JoystickAdapter
  def lever_on?(dir)
    pos = {
      :up    => 4,
      :right => 5,
      :down  => 6,
      :left  => 7,
    }[dir]
    if pos
      @object.button(pos)
    end
  end

  def button_on?(key)
    pos = {
      :btA => 15,
      :btB => 12,
      # :btC => 11,
      # :btD => 10,

      # PS3コントローラーの場合
      :btC => 13,
      :btD => 14,
    }[key]
    if pos
      @object.button(pos)
    end
  end
end
