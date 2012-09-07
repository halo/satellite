module Satellite
  module Client
    module Graphics
      module Extensions
        module Rotation

          # A Gosu Radian representing the angle of the image (0 is at the top)
          attr_accessor :a

          def initialize(options={})
            @a = options[:a] || 0
            super
          end

        end
      end
    end
  end
end