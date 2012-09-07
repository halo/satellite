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

        def update
          return if escape_exits!
          process_user_actions
        end

        def process_user_actions
          case layout.hit_action?(mouse)
          when :new_game
            send_event :new_game
          end
        end

        def layout
          @layout ||= Satellite::Client::Graphics::Layouts::Lobby.new
        end

      end
    end
  end
end