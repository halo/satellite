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

        def draw
          raise "Implement me in a subclass"
        end

      end
    end
  end
end
