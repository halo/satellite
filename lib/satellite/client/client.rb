require 'gosu'
require 'satellite/network/client'
require 'satellite/client/settings'
require 'satellite/client/input'
require 'satellite/client/manager/lobby'
require 'satellite/client/profile'

module Satellite
  module Client
    class Client < Gosu::Window

      # Internal: Convenience wrapper that makes it easier to stub the "global" window-variable in tests
      def self.window
        @@window
      end

      def self.profile
        @@profile ||= Profile.new gamertag: Settings.gamertag
      end

      def initialize
        super(Settings.screen_width, Settings.screen_height, false, 32)
        @@window = self
        @network = Network::Client.new port: Settings.listen_port, server_endpoint: Settings.server_endpoint, server_port: Settings.server_port
        @network.send_event Network::Event.new kind: :hello
        @input = Input::State.new
        @manager = Manager::Lobby.new
      end

      def start
        show
      end

      private

      def button_down(id)
        update_mouse_position
        @input.button_down id
      end

      def button_up(id)
        update_mouse_position
        @input.button_up id
      end

      def update_mouse_position
        @input.mouse_x = mouse_x.to_i
        @input.mouse_y = mouse_y.to_i
      end

      def update
        receive_network_events
        receive_user_input
        update_manager
        send_network_events
        switch_manager
      end

      def receive_network_events
        @network.receive_events do |event|
          @manager.on_event event
        end
      end

      def receive_user_input
        update_mouse_position
        @manager.on_input @input
      end

      def send_network_events
        while event = @manager.events_to_send.pop do
          @network.send_event event
        end
        @network.flush
      end

      def update_manager
        @manager.update
      end

      def switch_manager
        if new_manager = @manager.replace
          Log.debug "Switching Manager: #{@manager} -> #{new_manager}"
          @manager = new_manager
        end
      end

      def draw
        @manager.draw
        @manager.layout.cursor.draw_rot(mouse_x, mouse_y, 0, 0) if @manager.layout.cursor
      end

    end
  end
end