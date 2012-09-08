require 'satellite/client/controllers/default'
require 'satellite/client/graphics/layouts/briefing'

module Satellite
  module Client
    module Controllers
      class Briefing < Default

        def on_event(event)
          case event.kind
          when :players
            layout.players = event.data
          end
          super
        end

        def update
          return if escape_exits!
          process_user_actions
        end

        def process_user_actions
          case layout.hit_action?(mouse)
          when :start_game
            send_event :start_game
          when :ready
            send_event :ready
          when :unready
            send_event :unready
          end
        end

        def layout
          @layout ||= Satellite::Client::Graphics::Layouts::Briefing.new
        end

      end
    end
  end
end