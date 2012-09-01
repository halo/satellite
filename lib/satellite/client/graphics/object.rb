module Satellite
  module Client
    module Graphics
      class Object

        # Fixnums representing the coordinates of the object on the window
        attr_accessor :x, :y, :z

        # A Gosu Radian representing the angle of the image (0 is at the top)
        attr_accessor :a

        def initialize(options={})
          @x = options[:x] || 0
          @y = options[:y] || 0
          @z = options[:z] || 0
          @a = options[:a] || 0
        end

        def hit?(point_x, point_y)
          point_x > x && point_x < x2 && point_y > y && point_y < y2
        end

        def x2
          x + width
        end

        def y2
          y + height
        end

        def draw
          raise "Implement me in a subclass"
        end

      end
    end
  end
end
