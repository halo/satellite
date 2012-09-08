require 'satellite/client/graphics/layouts/default'
require 'satellite/client/graphics/text'

module Satellite
  module Client
    module Graphics
      module Layouts
        class Lobby < Default
          attr_reader :player_names

          def initialize(options={})
            super
            @player_names = []
          end

          def objects
            [title, players, new_game]
          end

          def hit_action?(mouse)
            return :new_game if mouse.clicked? && new_game.hit?(mouse.x, mouse.y)
          end

          def new_game
            @new_game_object ||= Graphics::Text.new(text: 'New Game', size: 4, y: players.height + 100)
          end

          def title
            @title_object ||= Graphics::Text.new(text: 'Lobby', size: 5)
          end

          def players
            @player_object ||= Graphics::Text.new(text: 'Players found: ' + player_names.join(", "), y: title.height + 20, size: 4)
          end

          def player_names=(names)
            @title_object.text = names.first
            #@player_names = names
            #@player_object = nil
          end

        end
      end
    end
  end
end