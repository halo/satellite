module Satellite
  module Client
    module Manager
      class Default
        attr_reader :events_to_send, :replace, :update_intervals, :layout
        attr_accessor :input

        def initialize(options={})
          @events_to_send = []
          @update_intervals = 0
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
          @update_intervals += 1
          on_update
        end

        # Internal: Callback for subclasses.
        def on_update
        end

        # Internal: The third steps of the Manager life-cycle.
        #           It draws the universe.
        #
        def draw
          layout.draw if layout
          layout.cursor.draw(mouse.x, mouse.y, 0) if layout.cursor && mouse.x
        end

        def switch(manager)
          @replace = manager
        end

        def to_s
          self.class.name.gsub('Satellite::Client::Manager::', '')
        end

        private

        def send_event(kind, data=nil)
          events_to_send << Network::Event.new(kind: kind, data: data)
        end

        def mouse
          input.mouse if input
        end

        def keyboard
          input.keyboard if input
        end

      end
    end
  end
end
