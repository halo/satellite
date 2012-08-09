require 'satellite/log'
require 'satellite/network/server'
require 'satellite/server/combat/manager'
require 'satellite/server/settings'
require 'satellite/extensions/core/time/milliseconds'

module Satellite
  module Server
    class Loop

      def initialize
        @network = Satellite::Network::Server.new port: Settings.listen_port
        @manager = Combat::Manager.new
        @updates_per_second = 60
        @updates = 0
      end

      # For an excellent article about game loops, see http://www.koonsolo.com/news/dewitters-gameloop
      def start
        Log.info "Starting server loop with framerate #{@updates_per_second}..."
        @started_at = Time.now.to_ms
        next_game_tick = Time.now.to_ms
        next_synchronization_tick = Time.now.to_ms
        loop do
          update_loops = 0
          while Time.now.to_ms > next_game_tick && update_loops < 5
            update
            next_game_tick += 1000 / @updates_per_second
            update_loops += 1
          end
        end
      end

      private

      def elapsed_milliseconds
        Time.now.to_ms - @started_at
      end

      def update
        @last_update_log ||= 0
        update!
        @network.flush
        @updates += 1
        if @last_update_log + 1000 < elapsed_milliseconds
          Log.debug "Game update #{@updates}"
          @last_update_log = elapsed_milliseconds
        end
      end

      def update!
        receive_events
        @manager.update
        send_events
      end

      def receive_events
        @network.receive_events do |id, name, data|
          @manager.on_event id, name, data
        end
      end

      def send_events
        @manager.events_to_send.each do |event|
          if event.broadcast?
            @network.broadcast event_name: event.name, data: event.data
          else
            @network.send_event id: event.player.id, event_name: event.name, data: event.data
          end
        end
      end

    end
  end
end