module Satellite
  module Client
    module Manager
      class Default
        attr_reader :events_to_send

        def initialize(options={})
          @events_to_send = []
        end

        # Internal: The first step of the life-cycle.
        #           It gathers all messages from the server.
        #
        def on_event(event)
        end

        # Internal: The second steps of the life-cycle.
        #           It updates the universe.
        #
        def update
        end

        # Internal: Instantiates the next Client::Manager.
        #
        # Returns: An Client::Manager::XXX instance or nil.
        def replace
        end

      end
    end
  end
end
