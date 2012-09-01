require 'satellite/log'
require 'satellite/server/manager/default'
require 'satellite/server/manager/models/player'
require 'satellite/server/manager/models/player_pool'

module Satellite
  module Server
    module Manager
      class Briefing < Default
        attr_reader :player_pool

        def initialize(options={})
          super
          @player_pool = options[:player_pool]
          @creator_id = options[:creator_id]
          broadcast :state, :briefing
        end

        def on_event(event)
          Log.debug "Got event: #{event.inspect}"


          broadcast :state, :briefing
        end

        def update
        end

        # In the lobby we need just about two updates per second (to save CPU power).
        def throttle
          2
        end

      end
    end
  end
end