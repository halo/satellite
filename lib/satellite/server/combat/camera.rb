module Satellite
  module Server
    module Combat
      class Camera
        attr_reader :x, :y

        def initialize(options={})
          object = options[:object]
          object_data = object.export
          @x = object_data.x
          @y = object_data.y
        end

      end
    end
  end
end
