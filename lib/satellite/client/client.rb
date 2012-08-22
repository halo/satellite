require 'gosu'
require 'satellite/network/client'
require 'satellite/client/settings'
require 'satellite/client/input'
require 'satellite/client/graphics/sprite'
require 'satellite/client/graphics/text'
require 'satellite/client/manager/lobby'

module Satellite
  module Client
    class Client < Gosu::Window

      # Internal: Convenience wrapper that makes it easier to stub the global variable in tests
      def self.window
        @@window
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
        @manager = @manager.replace if @manager.replace
        receive_events
        super
        send_events
        @network.flush
      end

      def receive_events
        @network.receive_events do |event|
          @manager.on_event event
        end
      end

      def send_events
        @manager.events_to_send.each do |event|
          @network.send_event kind: event.kind, data: event.data
        end
      end
    end
  end
end