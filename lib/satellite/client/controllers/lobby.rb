require 'satellite/client/controllers/dispatcher'
require 'satellite/client/graphics/layouts/lobby'

module Satellite
  module Client
    module Controllers
      class Lobby < Default

        def on_event(event)
          Log.debug "Got event: #{event.inspect}"
          case event.kind
          when :players
            layout.player_names = event.data

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
          @layout ||= Satellite::Client::Graphics::Layouts::Lobby.new
        end

        private

        def exit?
          if keyboard.escape?
            send_event :leave
            switch Dispatcher.dispatch :exit
            true
          end
        end

      end
    end
  end
end