require 'satellite/client/image'

module Satellite
  module Client
    class Sprite

      # Fixnums representing the coordinates of the sprite on the window
      attr_accessor :x, :y, :z, :a

      # A Gosu Radian representing the angle of the image (0 is at the top)
      #attr_accessor :a

      def initialize(options={})
        @image = Image.new(:name => options[:image_name])
        @x = options[:x]
        @y = options[:y]
        @z = options[:z]
        @a = options[:a]
      end

      def draw
        @image.draw_rot(x, y, z, a)
      end

    end
  end
end