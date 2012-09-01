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

        #def on_input(input)
        #  if keyboard.escape?
        #  end
        #  if mouse.clicked?
        #    Log.debug "Mouse single clicked"
        #  end
        #  if mouse.double_clicked?
        #    Log.debug "Mouse double clicked"
        #  end
        #  if mouse.rect?
        #    Log.debug "Mouse rectangle: #{mouse.rect.inspect}"
        #  end
        #end

        def on_update
          return if exit?
          if update_intervals % 30 == 0
            send_event :in_lobby, gamertag: Client.profile.gamertag
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