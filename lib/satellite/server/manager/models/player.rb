module Satellite
  module Server
    module Manager
      module Models
        class Player
          attr_reader :id, :gamertag

          def initialize(options={})
            @id = options[:id]
            @gamertag = options[:gamertag]
          end

        end
      end
    end
  end
end
