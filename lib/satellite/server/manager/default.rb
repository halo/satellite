module Satellite
  module Server
    module Manager
      class Default
        attr_reader :events_to_send, :replace

        def initialize(options={})
          @events_to_send = []
        end

        # Internal: The first (of two) step of the life-cycle.
        #           It gathers all messages from all clients.
        #
        def on_event(event)
        end

        # Internal: The last (of two) steps of the life-cycle.
        #           It updates the universe.
        #
        def update
        end

        # Internal: Define roughly how many updates per second should take place.
        #           Return nil for recommended maximum.
        #
        # Returns: Integer or nil.
        def throttle
        end

        private

        def broadcast(kind, data=nil)
          events_to_send << Network::Event.new(kind: kind, data: data)
        end

        def switch(manager)
          @replace = manager
        end

      end
    end
  end
end