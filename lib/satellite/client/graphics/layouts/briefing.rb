require 'satellite/client/graphics/layouts/default'
require 'satellite/client/graphics/text'

module Satellite
  module Client
    module Graphics
      module Layouts
        class Briefing < Default
          attr_reader :ready_player_names, :unready_player_names
          attr_writer :can_start_game, :ready

          def initialize(options={})
            super
            @ready_player_names = []
            @unready_player_names = []
          end

          def objects
            result = [title, ready_players, unready_players]
            if can_toggle_ready?
              result << (ready? ? unready_button : ready_button)
            end
            result << start_game if can_start_game?
            result
          end

          def hit_action?(mouse)
            return nil unless mouse.clicked?
            return :start_game if start_game.hit?(mouse.x, mouse.y)
            return :ready if ready_button.hit?(mouse.x, mouse.y)
            return :unready if unready_button.hit?(mouse.x, mouse.y)
          end

          def title
            @title_object ||= Graphics::Text.new(text: 'Briefing', size: 5)
          end

          def start_game
            @start_game_object ||= Graphics::Text.new(text: 'Start Game', size: 4, y: unready_players.bottom + 5)
          end

          def ready_button
            @ready_button_object ||= Graphics::Text.new(text: 'Ready?', size: 4, y: unready_players.bottom + 5)
          end

          def unready_button
            @unready_button_object ||= Graphics::Text.new(text: 'Unready?', size: 4, y: unready_players.bottom + 5)
          end

          def ready_players
            @ready_players_object ||= Graphics::Text.new(text: 'Ready players: ' + ready_player_names.join(", "), y: title.bottom + 5, size: 4)
          end

          def unready_players
            @unready_players_object ||= Graphics::Text.new(text: 'Waiting for players: ' + unready_player_names.join(", "), y: ready_players.bottom + 5, size: 4)
          end

          def ready_player_names=(names)
            @ready_player_names = names
            @ready_players_object = nil
          end

          def unready_player_names=(names)
            @unready_player_names = names
            @unready_players_object = nil
          end

          def can_start_game?
            !!@can_start_game
          end

          def can_toggle_ready?
            !can_start_game?
          end

          def ready?
            !!@ready
          end

        end
      end
    end
  end
end