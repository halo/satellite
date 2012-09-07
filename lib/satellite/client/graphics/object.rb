require 'satellite/client/graphics/extensions/default'
require 'satellite/client/graphics/extensions/position'
require 'satellite/client/graphics/extensions/rotation'
require 'satellite/client/graphics/extensions/geometry'
require 'satellite/client/graphics/extensions/interaction'

module Satellite
  module Client
    module Graphics
      class Object

        include Extensions::Default
        include Extensions::Position
        include Extensions::Rotation
        include Extensions::Geometry
        include Extensions::Interaction

        def draw
          raise "Implement me in a subclass"
        end

      end
    end
  end
end
