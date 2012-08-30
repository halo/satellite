require 'satellite/log'
require 'satellite/network/server'
require 'satellite/server/loop'
require 'satellite/server/manager/lobby'
require 'satellite/server/settings'
require 'satellite/extensions/core/object/random'

module Satellite
  module Server
    class Server

      def initialize(options={})
        @network = Satellite::Network::Server.new port: Settings.listen_port
        @manager = Manager::Lobby.new
        @loop = Loop.new
      end

      def start
        Log.info "Starting server..."
        start!
      rescue Interrupt
        Log.info "Exiting server."
      end

      private

      def start!
        @loop.start do
          update
          sleep (1.0 / @manager.throttle) if @manager.throttle
        end
      end

      def update
        @manager = @manager.replace if @manager.replace
        receive_events
        @manager.update
        send_events
        @network.flush
      end

      def receive_events
        @network.receive_events do |event|
          @manager.on_event event
        end
      end

      def send_events
        while event = @manager.events_to_send.pop
          if event.broadcast?
            @network.broadcast event
          else
            @network.send_event event
          end
        end
      end

    end
  end
end
