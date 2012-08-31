require 'satellite/client/input/state/mouse'
require 'satellite/client/input/state/key'

module Satellite
  module Client
    module Input
      class State
        attr_accessor :mouse_x, :mouse_y
        attr_reader :key, :mouse

        def initialize
          @mouse = Mouse.new
          @key = Key.new
        end

        def button_down(gosu_key_id)
          update_mouse_position
          mouse.button_down gosu_key_id
          key.button_down gosu_key_id
        end

        def button_up(gosu_key_id)
          update_mouse_position
          mouse.button_up gosu_key_id
          key.button_up gosu_key_id
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