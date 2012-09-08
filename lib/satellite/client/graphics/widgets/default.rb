require 'satellite/client/graphics/extensions/default'
require 'satellite/client/graphics/extensions/position'
require 'satellite/client/graphics/extensions/geometry'
require 'satellite/client/graphics/extensions/interaction'

module Satellite
  module Client
    module Graphics
      module Widgets
        class Default

          include Extensions::Default
          include Extensions::Position
          include Extensions::Geometry
          include Extensions::Interaction

          def initialize(options={})
            super
            @x = default_x
            @y = default_y
          end

          def objects
            []
          end

          def x
            objects.min(&:x).x
          end

          def y
            objects.min(&:y).y
          end

          def height
            x + objects.max(&:height).height
          end

          def width
            y + objects.max(&:width).width
          end

          def default_x
            20
          end

          def default_y
            20
          end

          def draw
            objects.each(&:draw)
          end

        end
      end
    end
  end
end