require 'satellite/log'
require 'satellite/server/controllers/menu'

module Satellite
  module Server
    module Controllers
      class Briefing < Menu
        attr_reader :player_pool, :creator_id

        def initialize(options={})
          super
          @player_pool = options[:player_pool]
          @creator_id = options[:creator_id]
        end

        def on_event(event)
          Log.debug "Got event: #{event.inspect}"
        end

      end
    end
  end
end