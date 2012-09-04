require 'satellite/client/controllers/default'
require 'satellite/client/controllers/exit'
require 'satellite/client/controllers/briefing'
require 'satellite/client/graphics/layout/lobby'

module Satellite
  module Client
    module Controllers
      class Lobby < Default

        def on_event(event)
          Log.debug "Got event: #{event.inspect}"
          case event.kind
          when :players_in_lobby
            layout.player_names = event.data
          when :state
            if event.data == :briefing
              switch Briefing.new
            end

          end
        end

        def on_update
          return if exit?

          case layout.hit_action?(mouse)
          when :new_game
            send_event :new_game
          end

          if update_intervals % 30 == 0
            send_event :in_lobby, gamertag: profile.gamertag
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