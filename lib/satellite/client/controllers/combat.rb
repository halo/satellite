module Satellite
  module Client
    module Controllers
      class Combat < Default

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
                @sprites[id] = Sprite.new image_name: entity.image_name, x: (Settings.screen_width / 2), y: (Settings.screen_height / 2), z: entity.z, a: entity.a.radians_to_gosu
              end
            end
          end
        end

        def draw
          @sprites.values.each do |sprite|
            sprite.draw
          end
          #draw_gui
        end

        #def draw_gui
        #  Graphics::Text.new(:text => 'Welcome to Satellite').draw
        #end

        def button_down(key)
          send_event :button_down, key
        end

        def button_up(key)
          send_event :button_up, key
        end

      end
    end
  end
end