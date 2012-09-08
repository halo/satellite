require 'satellite/server/controllers/meeting'
require 'satellite/server/controllers/briefing'

module Satellite
  module Server
    module Controllers
      class Lobby < Meeting

        def on_event(event)
          super
          case event.kind
          when :new_game
            switch Briefing.new creator_id: event.sender_id
          end
        end

        def update
          broadcast :players, players.export_for_lobby
          super
        end

      end
    end
  end
end