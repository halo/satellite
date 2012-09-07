module Satellite
  module Client
    module Graphics
      module Extensions
        module Geometry

          def left
            x
          end

          def right
            x + width
          end

          def top
            y
          end

          def bottom
            y + width
          end

        end
      end
    end
  end
end