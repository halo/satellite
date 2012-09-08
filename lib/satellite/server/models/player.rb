require 'satellite/log'

module Satellite
  module Server
    module Controllers
      module Models
        class Player
          attr_reader :id, :gamertag

          def initialize(options={})
            @id = options[:id]
            @gamertag = options[:gamertag]
          end

          def ready?
            !!@ready
          end

          def toggle_ready!
            @ready = @ready
          end

          def export_for_lobby
            { gamertag: gamertag }
          end

          def export_for_briefing
            { gamertag: gamertag, ready: ready? }
          end

        end
      end
    end
  end
end
