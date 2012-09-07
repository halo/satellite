require 'satellite/client/controllers/default'
require 'satellite/client/controllers/dispatcher'
require 'satellite/log'

module Satellite
  module Client
    module Controllers
      class Loading < Default

        def on_event(event)
          return unless event.kind == :state
          if new_controller = Dispatcher.dispatch(event.data)
            switch new_controller
          end
        end

        def throttled_update
          send_event :presence, gamertag: profile.gamertag
        end

      end
    end
  end
end