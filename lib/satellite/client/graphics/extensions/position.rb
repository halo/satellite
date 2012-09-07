module Satellite
  module Client
    module Graphics
      module Extensions
        module Position

          # Fixnums representing the coordinates of the object on the window
          attr_accessor :x, :y, :z

          def initialize(options={})
            @x = options[:x] || 0
            @y = options[:y] || 0
            @z = options[:z] || 0
            super
          end

        end
      end
    end
  end
end