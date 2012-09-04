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

          def export
            data.values.map(&:gamertag)
          end

        end
      end
    end
  end
end