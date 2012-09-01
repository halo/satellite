require 'satellite/client/input/devices/mouse'
require 'satellite/client/input/devices/keyboard'

module Satellite
  module Client
    module Input
      class State
        attr_reader :mouse_x, :mouse_y
        attr_reader :keyboard, :mouse

        def initialize
          @mouse = Devices::Mouse.new
          @keyboard = Devices::Keyboard.new
        end

        def button_down(gosu_key_id)
          update_mouse_position
          mouse.button_down gosu_key_id
          keyboard.button_down gosu_key_id
        end

        def button_up(gosu_key_id)
          update_mouse_position
          mouse.button_up gosu_key_id
          keyboard.button_up gosu_key_id
        end

        def mouse_x=(x)
          @mouse_x = x
          mouse.x = @mouse_x
        end

        def mouse_y=(y)
          @mouse_y = y
          mouse.y = @mouse_y
        end

        private

        def update_mouse_position
          mouse.x = mouse_x
          mouse.y = mouse_y
        end

      end
    end
  end
end