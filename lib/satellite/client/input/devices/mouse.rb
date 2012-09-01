require 'satellite/client/input/devices/default'

module Satellite
  module Client
    module Input
      module Devices
        class Mouse < Default
          attr_accessor :x, :y

          def self.mapping
            {
              MsLeft   => :left,
              MsRight  => :right,
            }
          end

          def clicked?
            pressed.include? :left
          end

        end
      end
    end
  end
end