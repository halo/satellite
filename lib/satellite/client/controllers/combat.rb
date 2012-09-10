require 'satellite/client/graphics/sprite'

module Satellite
  module Client
    module Controllers
      class Combat < Default
        attr_accessor :last_input_export

        def initialize(options={})
          super
          @sprites = {}
        end

        def on_event(event)
          case event.kind
          when :field
            event.data.camera
            event.data.entities.each do |entity|
              id = entity.id
              if @sprites[id]
                @sprites[id].x = entity.x + (Settings.screen_width / 2)
                @sprites[id].y = entity.y + (Settings.screen_height / 2)
                @sprites[id].z = entity.z
                @sprites[id].a = entity.a.radians_to_gosu
              else
                @sprites[id] = Graphics::Sprite.new image_name: entity.image_name, x: (Settings.screen_width / 2), y: (Settings.screen_height / 2), z: entity.z, a: entity.a.radians_to_gosu
              end
            end
          end
        end

        def update
          input_export = input.export
          if last_input_export != input_export
            last_input_export = input_export
            send_event :input, input_export
          end
        end

        def draw
          @sprites.values.each do |sprite|
            sprite.draw
          end
        end

        def button_down(key)
          send_event :button_down, keyboard.key(key)
        end

        def button_up(key)
          send_event :button_up, keyboard.key(key)
        end

      end
    end
  end
end