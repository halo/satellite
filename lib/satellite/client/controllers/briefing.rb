require 'satellite/client/controllers/default'
require 'satellite/client/graphics/layouts/briefing'

module Satellite
  module Client
    module Controllers
      class Briefing < Default

        def on_event(event)
          case event.kind
          when :players
            layout.ready_player_names = []
            layout.unready_player_names = []
            event.data.each do |player|
              if player[:ready]
                layout.ready_player_names << player[:gamertag]
              else
                layout.unready_player_names << player[:gamertag]
              end
            end
          when :ready
            layout.ready = event.data
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
          when :ready, :unready
            send_event :ready
          end
        end

        def layout
          @layout ||= Satellite::Client::Graphics::Layouts::Briefing.new
        end

      end
    end
  end
end