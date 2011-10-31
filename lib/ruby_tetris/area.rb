class Field
  class Area
    attr_accessor :width, :height

    def initialize(args)
      if args.kind_of? Area
        self.width = args.width
        self.height = args.height
      else
        @width, @height = *args
      end
    end

    def left
      0
    end

    def top
      0
    end

    def right
      width - 1
    end

    def bottom
      height - 1
    end

    def contains(x, y)
      x.between?(left, right) && y.between?(top, bottom)
    end
  end
end
