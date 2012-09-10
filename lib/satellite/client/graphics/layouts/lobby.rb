require 'satellite/client/graphics/layouts/default'
require 'satellite/client/graphics/widgets/list'
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
            [title_widget, candidates_widget, new_game_button]
          end

          def hit_action?(mouse)
            return nil unless mouse.clicked?
            return :new_game if new_game_button.hit?(mouse.x, mouse.y)
          end

          def new_game_button
            @new_game_button ||= Graphics::Text.new(text: 'New Game', size: 4, x: 20, y: 100)
          end

          def title_widget
            @title_widget ||= Widgets::Title.new text: self.class.name.split('::').last
          end

          def candidates_widget
            @candidates_widget ||= Widgets::List.new title: 'Players', records: candidate_names, y: title_widget.y, x: (Client.window.width / 2)
          end

          def candidates=(new_candidates)
            @candidates = new_candidates
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