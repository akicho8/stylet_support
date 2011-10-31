# Gdk/SDLのクラス設計図

module UI
  class GuiAbstract
    include Singleton
    def width
    end
    def height
    end
    def bg_clear
    end
    def polling
    end
    def draw_begin
    end
    def draw_end
    end
    def set_title(title)
    end
    def gprint(x, y, str)
    end
    def draw_line(x, y, w, h, color)
    end
    def draw_rect(x, y, w, h, color)
    end
    def fill_rect(x, y, w, h, color)
    end
    def save_bmp(fname)
    end
  end
end
