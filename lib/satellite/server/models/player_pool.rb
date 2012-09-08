require 'satellite/server/models/pool'
require 'satellite/server/models/player'

module Satellite
  module Server
    module Controllers
      module Models
        class PlayerPool < Pool

          def object_class
            Player
          end

          def export_for_lobby
            data.values.map(&:export_for_lobby)
          end

          def export_for_briefing(for_player=nil)
            data.values.map do |player|
              result = player.export_for_briefing
              result.merge!({ you: for_player.id == player.id }) if for_player
              result
            end
          end

        end
      end
    end
  end
end