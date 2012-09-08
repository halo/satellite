require 'satellite/log'
require 'satellite/server/controllers/menu'
require 'satellite/server/models/player'
require 'satellite/server/models/player_pool'

module Satellite
  module Server
    module Controllers
      class Meeting < Menu
        include Models

        def on_event(event)
          #Log.debug "Got in #{state.inspect}: #{event.inspect}"
          if event.data && event.data[:state] == state
            case event.kind
            when :presence
              unless players.find event.sender_id
                players << Player.new(id: event.sender_id, gamertag: event.data[:gamertag])
              end
            when :leave
              players.delete event.sender_id
            end
          end
          super
        end

        def players
          @players ||= PlayerPool.new
        end

      end
    end
  end
end