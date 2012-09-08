require 'satellite/client/graphics/layouts/default'
require 'satellite/client/graphics/text'

module Satellite
  module Client
    module Graphics
      module Layouts
        class Lobby < Default
          attr_accessor :candidates

          def initialize(options={})
            super
            @candidates = []
          end

          def objects
            [title_widget, candidates_widget, new_game]
          end

          def hit_action?(mouse)
            return :new_game if mouse.clicked? && new_game.hit?(mouse.x, mouse.y)
          end

          def new_game
            @new_game_object ||= Graphics::Text.new(text: 'New Game', size: 4, y: players.height + 100)
          end

          def title_widget
            @title_widget ||= Widgets::Title.new text: self.class.name.split('::').last
          end

          def candidates_widget
            @candidates_widget ||= Widgets::List.new title: 'Players', records: candidate_names
          end

          def candidates=(new_candidates)
            super
            candidates_widget.records = candidate_names
          end

          def candidate_names
            candidates.map(&:gamertag)
          end

        end
      end
    end
  end
end