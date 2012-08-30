require 'satellite/client/manager/default'
require 'satellite/client/manager/exit'
require 'satellite/client/graphics/layout/lobby'

module Satellite
  module Client
    module Manager
      class Lobby < Default

        def on_event(event)
          Log.debug "Got event: #{event.inspect}"
          case event.kind
          when :players_in_lobby
            layout.player_names = event.data
          end
        end

        def update
          super
          if update_intervals % 30 == 0
            send_event :in_lobby, gamertag: Client.profile.gamertag
          end
        end

        def layout
          @layout ||= Satellite::Client::Graphics::Layout::Lobby.new
        end

        def button_up(key)
          if key == :escape
            send_event :leave
            switch Exit.new
          end
        end

      end
    end
  end
end