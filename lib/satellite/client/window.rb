require 'gosu'
require 'satellite/network/client'
require 'satellite/client/settings'
require 'satellite/client/input'
require 'satellite/client/sprite'

module Satellite
  module Client
    class Window < Gosu::Window

      def initialize
        super(Settings.screen_width, Settings.screen_height, false, 32)
        $window = self
        @network = Network::Client.new port: Settings.listen_port, server_endpoint: Settings.server_endpoint, server_port: Settings.server_port
        @network.send_event event_name: :join
        @sprites = {}
      end

      def update
        receive_events
        @network.flush
        super
      end

      def receive_events
        @network.receive_events do |name, data|
          on_event name, data
        end
      end

      def on_event(name, data)
        case name
        when :field
          data.camera
          data.entities.each do |entity|
            id = entity.id
            if @sprites[id]
              @sprites[id].x = entity.x + (Settings.screen_width / 2)
              @sprites[id].y = entity.y + (Settings.screen_height / 2)
              @sprites[id].z = entity.z
              @sprites[id].a = entity.a.radians_to_gosu
            else
              Log.debug "Loading #{entity.inspect}"
              @sprites[id] = Sprite.new image_name: entity.image_name, x: (Settings.screen_width / 2), y: (Settings.screen_height / 2), z: entity.z, a: entity.a.radians_to_gosu
            end
          end
        end
      end

      def draw
        @sprites.values.each do |sprite|
          sprite.draw
        end
      end

      def button_down(id)
        key = Input.key(id)
        @network.send_event event_name: :button_down, data: key
      end

      def button_up(id)
        key = Input.key(id)
        if key == :escape
          @network.send_event event_name: :leave
          close
        end
        @network.send_event event_name: :button_up, data: key
      end

    end
  end
end