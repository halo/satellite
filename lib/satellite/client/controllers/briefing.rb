require 'satellite/client/controllers/default'
require 'satellite/client/controllers/exit'
require 'satellite/client/graphics/layout/lobby'

module Satellite
  module Client
    module Controllers
      class Briefing < Default

        def on_event(event)
          Log.debug "Got event: #{event.inspect}"
        end

        def on_update
          return if exit?

          if update_intervals % 30 == 0
            send_event :in_briefing, gamertag: profile.gamertag
          end
        end

        def layout
          @layout ||= Satellite::Client::Graphics::Layout::Lobby.new
        end

        private

        def exit?
          if keyboard.escape?
            send_event :leave
            switch Exit.new
            true
          end
        end

      end
    end
  end
end