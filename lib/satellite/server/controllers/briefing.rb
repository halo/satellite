require 'satellite/log'
require 'satellite/server/controllers/meeting'

module Satellite
  module Server
    module Controllers
      class Briefing < Meeting
        attr_reader :player_pool, :creator_id

        def initialize(options={})
          super
          @creator_id = options[:creator_id]
        end

        def on_event(event)
          super
          case event.kind
          when :ready
            players.find(event.sender_id).toggle_ready!
          when :start_game
            if ready? && event.sender_id == creator_id
              switch Loading.new creator_id: event.sender_id
            end
          end
        end

        def update
          super
          players.all.each do |player|
            send_event player.id, :players, players.export_for_briefing(player)
          end
        end

        def ready?
          players.all.all?(&:ready?)
        end

      end
    end
  end
end