require 'satellite/client/graphics/layouts/default'
require 'satellite/client/graphics/text'
require 'satellite/client/graphics/widgets/title'

module Satellite
  module Client
    module Graphics
      module Layouts
        class Briefing < Default
          attr_accessor :candidates

          def initialize(options={})
            super
            @candidates = []
          end

          def me
            candidates.detect(&:you)
          end

          def objects
            result = [title_widget, ready_candidates_widget, unready_candidates_widget]
            return result unless me
            if me.can_be_ready
              result << (me.ready ? unready_button : ready_button)
            end
            result << start_game_button if me.can_start_game
            result << you_created_game if me.created_game
            result
          end

          def title_widget
            @title_widget ||= Widgets::Title.new text: self.class.name.split('::').last
          end

          def start_game_button
            @start_game_button ||= Graphics::Text.new(text: 'Start Game', size: 4, y: ready_button.bottom + 10, x: 20)
          end

          def ready_button
            @ready_button ||= Graphics::Text.new(text: 'Ready?', size: 4, x: 20, y: 100)
          end

          def unready_button
            @unready_button ||= Graphics::Text.new(text: 'Unready?', size: 4, x: 20, y: 100)
          end

          def ready_candidates_widget
            @ready_candidates_widget ||= Widgets::List.new title: 'Ready Players', records: ready_candidate_names, y: title_widget.y, x: (Client.window.width / 3)
          end

          def unready_candidates_widget
            @unready_candidates_widget ||= Widgets::List.new title: 'Waiting for Players', records: unready_candidate_names, y: ready_candidates_widget.y, x: ready_candidates_widget.right
          end

          def you_created_game
            @you_created_game_text ||= Graphics::Text.new(text: 'You created this game!', y: 50, x: 20, size: 4)
          end

          def candidates=(new_candidates)
            @candidates = new_candidates
            ready_candidates_widget.records = ready_candidate_names
            unready_candidates_widget.records = unready_candidate_names
          end

          def ready_candidate_names
            candidates.select(&:ready).map(&:gamertag)
          end

          def unready_candidate_names
            candidates.reject(&:ready).map(&:gamertag)
          end

          def hit_action?(mouse)
            return nil unless mouse.clicked?
            return :start_game if me && me.can_start_game && start_game_button.hit?(mouse.x, mouse.y)
            return :ready if me && !me.ready && ready_button.hit?(mouse.x, mouse.y)
            return :unready if me && me.ready && unready_button.hit?(mouse.x, mouse.y)
          end

        end
      end
    end
  end
end