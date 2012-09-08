require 'satellite/client/graphics/layouts/default'
require 'satellite/client/graphics/text'

module Satellite
  module Client
    module Graphics
      module Layouts
        class Briefing < Default
          attr_reader :players

          def initialize(options={})
            super
            @players = []
            @ready_player_names = []
            @unready_player_names = []
          end

          def players=(all_players)
            @players = all_players
            @ready_player_names = []
            @unready_player_names = []
            @players.each do |player|
              if player[:ready]
                @ready_player_names << player[:gamertag]
              else
                @unready_player_names << player[:gamertag]
              end
            end
            @ready_players_object = nil
            @unready_players_object = nil
          end

          def me
            players.detect { |player| player[:you] }
          end

          def objects
            result = [title, ready_players, unready_players]
            return result unless me
            if me[:can_be_ready]
              result << (me[:ready] ? unready_button : ready_button)
            end
            result << start_game_button if me[:can_start_game]
            result << you_created_game if me[:created_game]
            result
          end

          def title
            @title_object ||= Graphics::Text.new(text: 'Briefing', size: 5)
          end

          def start_game_button
            @start_game_object ||= Graphics::Text.new(text: 'Start Game', size: 4, y: ready_button.bottom + 10)
          end

          def ready_button
            @ready_button_object ||= Graphics::Text.new(text: 'Ready?', size: 4, y: unready_players.bottom + 10)
          end

          def unready_button
            @unready_button_object ||= Graphics::Text.new(text: 'Unready?', size: 4, y: unready_players.bottom + 10)
          end

          def ready_players
            @ready_players_object ||= Graphics::Text.new(text: 'Ready players: ' + @ready_player_names.join(", "), y: title.bottom + 10, size: 4)
          end

          def unready_players
            @unready_players_object ||= Graphics::Text.new(text: 'Waiting for players: ' + @unready_player_names.join(", "), y: ready_players.bottom + 10, size: 4)
          end

          def you_created_game
            @you_created_game_object ||= Graphics::Text.new(text: 'You created this game!', y: title.top, x: title.right + 10, size: 4)
          end

          def hit_action?(mouse)
            return nil unless mouse.clicked?
            return :start_game if me && me[:can_start_game] && start_game_button.hit?(mouse.x, mouse.y)
            return :ready if me && !me[:ready] && ready_button.hit?(mouse.x, mouse.y)
            return :unready if me && me[:ready] && unready_button.hit?(mouse.x, mouse.y)
          end

        end
      end
    end
  end
end