module Satellite
  module Client
    module Manager
      class Default
        attr_reader :events_to_send, :replace

        def initialize(options={})
          @events_to_send = []
        end

        # Internal: The first step of the Manager life-cycle.
        #           It gathers all messages from the server.
        #
        def on_event(event)
        end

        # Internal: The second steps of the Manager life-cycle.
        #           It updates the universe.
        #
        def update
        end

        # Internal: The third steps of the Manager life-cycle.
        #           It draws the universe.
        #
        def draw
        end

        def switch(manager)
          @replace = manager
        end

        def button_down(key)
        end

        def button_up(key)
        end

        def to_s
          self.class.name.gsub('Satellite::Client::Manager::', '')
        end

      end
    end
  end
end
