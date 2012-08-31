require 'satellite/client/graphics/layout/default'
require 'satellite/client/graphics/text'

module Satellite
  module Client
    module Graphics
      module Layout
        class Lobby < Default
          attr_reader :player_names

          def initialize(options={})
            super
            @player_names = []
          end

          def objects
            [title, players, new_game]
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
            @player_names = names
            @player_object = nil
          end

        end
      end
    end
  end
end