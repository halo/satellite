require 'satellite/client/graphics/image'

module Satellite
  module Client
    module Graphics
      module Layout
        class Default
          attr_accessor :objects, :cursor

          def initialize(options={})
            @objects = []
            @cursor = Image.new name: 'cursors/default.png'
          end

          def draw
            objects.each(&:draw)
          end

        end
      end
    end
  end
end