require 'satellite/client/graphics/object'
require 'satellite/client/graphics/image'

module Satellite
  module Client
    module Graphics
      class Sprite < Object

        def initialize(options={})
          super
          @image = Image.new(:name => options[:image_name])
        end

        def draw
          @image.draw_rot(x, y, z, a)
        end

      end
    end
  end
end