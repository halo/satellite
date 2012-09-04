require 'satellite/log'
require 'satellite/server/controllers/menu'
require 'satellite/server/controllers/briefing'
require 'satellite/server/models/player'
require 'satellite/server/models/player_pool'

module Satellite
  module Server
    module Controllers
      class Lobby < Menu
        include Models

        def on_event(event)
          Log.debug "Got event: #{event.inspect}"
          case event.kind
          when :presence
            if event.data[:state] == state
              player_pool << Player.new(id: event.sender_id, gamertag: event.data[:gamertag])
            end
          when :new_game
            switch Briefing.new creator_id: event.sender_id, player_pool: player_pool
          when :leave
            player_pool.delete event.sender_id
          end
        end

        def update
          broadcast :players, player_pool.export
        end

        def player_pool
          @player_pool ||= PlayerPool.new
        end

      end
    end
  end
end