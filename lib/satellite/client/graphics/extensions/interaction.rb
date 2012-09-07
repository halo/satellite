module Satellite
  module Client
    module Graphics
      module Extensions
        module Interaction

          def hit?(x, y)
            x.between?(left, right) && y.between?(top, bottom)
          end

        end
      end
    end
  end
end