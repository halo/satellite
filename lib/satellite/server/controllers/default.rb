require 'satellite/log'
require 'satellite/extensions/core/string/inflections'

module Satellite
  module Server
    module Controllers
      class Default
        attr_reader :events_to_send, :replace

        def initialize(options={})
          @events_to_send = []
        end

        # Public: Step 1 of 2 of the life-cycle. It gathers all messages from all clients.
        #         This method is called once per network event.
        #
        def process_event(event)
          on_event(event)
        end

        # Internal: Step 2 of 2 of the life-cycle. It updates the universe.
        #           This method is called once per game loop tick.
        #
        def process_update
          update
        end

        # Internal: Define roughly how many updates per second should take place.
        #           Return nil for maximum.
        #
        # Returns: Integer or nil.
        def throttle
        end

        private

        # Internal: Convenience callback of process_event for subclasses.
        #
        def on_event(event)
        end

        # Internal: Convenience callback of process_update for subclasses.
        #
        def update
        end

        # Internal: Enqueues a network event to be sent to all clients.
        #
        def broadcast(kind, data=nil)
          events_to_send << Network::Event.new(kind: kind, data: data)
        end

        # Internal: Enqueues a network event to be sent to one client.
        #
        def send_event(receiver_id, kind, data=nil)
          events_to_send << Network::Event.new(receiver_id: receiver_id, kind: kind, data: data)
        end

        # Internal: Inform all clients of the current controller.
        #
        def broadcast_state
          broadcast :state, state
        end

        # Internal: The name of this controller state.
        def state
          self.class.name.gsub('Satellite::Server::Controllers::', '').underscore.to_sym
        end

        # Internal: This controller dies now, mark for switching to another Controller.
        #
        def switch(controller)
          @replace = controller
        end

      end
    end
  end
end