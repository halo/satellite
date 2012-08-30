require 'satellite/log'
require 'satellite/server/manager/default'

module Satellite
  module Server
    module Manager
      class Lobby < Default

        def initialize(options={})
          super
          @players = Set.new
        end

        def on_event(event)
          Log.debug "Got event: #{event.inspect}"
          case event.kind
          when :in_lobby
            @players << event.data[:gamertag]
            broadcast :players_in_lobby, @players.to_a
          end
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