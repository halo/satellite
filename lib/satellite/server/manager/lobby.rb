require 'satellite/log'
require 'satellite/server/manager/base'

module Satellite
  module Server
    module Manager
      class Lobby < Default

        def on_event(event)
          Log.debug "Got event: #{event.inspect}"
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