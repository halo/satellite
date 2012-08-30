require 'satellite/server/manager/models/pool'
require 'satellite/server/manager/models/player'

module Satellite
  module Server
    module Manager
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