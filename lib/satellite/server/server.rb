require 'satellite/log'
require 'satellite/network/server'
require 'satellite/server/loop'
require 'satellite/server/controllers/lobby'
require 'satellite/server/settings'

module Satellite
  module Server
    class Server

      def initialize(options={})
        @network = Satellite::Network::Server.new port: Settings.listen_port
        @controller = Controllers::Lobby.new
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
          sleep (1.0 / @controller.throttle) if @controller.throttle
        end
      end

      def update
        receive_network_events
        update_controller
        send_network_events
        switch_controller
      end

      def receive_network_events
        @network.receive_events do |event|
          @controller.process_event event
        end
      end

      def update_controller
        @controller.process_update
      end

      def send_network_events
        while event = @controller.events_to_send.pop
          if event.broadcast?
            @network.broadcast event
          else
            @network.send_event event
          end
        end
        @network.flush
      end

      def switch_controller
        if new_controller = @controller.replace
          Log.debug "Switching Manager: #{@controller} -> #{new_controller}"
          @controller = new_controller
        end
      end

    end
  end
end
