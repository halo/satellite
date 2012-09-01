require 'satellite/client/input/devices/default'

module Satellite
  module Client
    module Input
      module Devices
        class Keyboard < Default

          def self.mapping
            {
              KbLeft   => :left,
              KbRight  => :right,
              KbUp     => :up,
              KbDown   => :down,
              KbEscape => :escape,
            }
          end

          def escape?
            pressed.include? :escape
          end

        end
      end
    end
  end
end