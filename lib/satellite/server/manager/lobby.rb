require 'satellite/log'
require 'satellite/server/manager/default'
require 'satellite/server/manager/briefing'
require 'satellite/server/manager/models/player'
require 'satellite/server/manager/models/player_pool'

module Satellite
  module Server
    module Manager
      class Lobby < Default
        attr_reader :player_pool

        def initialize(options={})
          super
          @player_pool = Models::PlayerPool.new
          broadcast :state, :lobby
        end

        def on_event(event)
          Log.debug "Got event: #{event.inspect}"
          case event.kind
          when :in_lobby
            player_pool << Models::Player.new(id: event.sender_id, gamertag: event.data[:gamertag])
            broadcast :players_in_lobby, player_pool.export
          when :leave
            player_pool.delete event.sender_id
            broadcast :players_in_lobby, player_pool.export
          when :new_game
            switch Briefing.new creator_id: event.sender_id, player_pool: player_pool
          end
          broadcast :state, :lobby
        end

        def update
        end

        # In the lobby we need just about two updates per second (to save CPU power).
        def throttle
          2
        end

      end
    end
  end
end