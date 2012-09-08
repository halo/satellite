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

          def to_hash(*keys)
            data.values.map do |player|
              player.to_hash(*keys)
            end
          end

        end
      end
    end
  end
end