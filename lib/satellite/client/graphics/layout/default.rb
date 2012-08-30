module Satellite
  module Client
    module Graphics
      module Layout
        class Default
          attr_accessor :objects

          def initialize(options={})
            @objects = []
          end

          def draw
            objects.each(&:draw)
          end

        end
      end
    end
  end
end