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
        @manager = Manager::Lobby.new
      end

      def start
        show
      end

      private

      def update
        receive_events
        @manager.update
        send_events
        switch_manager
      end

      def draw
        @manager.draw
      end

      def receive_events
        @network.receive_events do |event|
          @manager.on_event event
        end
      end

      def send_events
        while event = @manager.events_to_send.pop do
          @network.send_event event
        end
        @network.flush
      end

      def button_down(id)
        @manager.button_down Input.key(id)
      end

      def button_up(id)
        @manager.button_up Input.key(id)
      end

      private

      def switch_manager
        if new_manager = @manager.replace
          Log.debug "Switching Manager: #{@manager} -> #{new_manager}"
          @manager = new_manager
        end
      end

    end
  end
end