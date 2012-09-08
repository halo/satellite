require 'satellite/log'

module Satellite
  module Server
    module Controllers
      module Models
        class Player
          attr_reader :id, :gamertag
          attr_writer :ready

          def initialize(options={})
            @id = options[:id]
            @gamertag = options[:gamertag]
            @ready = false
          end

          def ready?
            !!@ready
          end

          def to_hash(*keys)
            all = { gamertag: gamertag, ready: ready? }
            all.select { |key, value| keys.include?(key) } if keys
          end

        end
      end
    end
  end
end
