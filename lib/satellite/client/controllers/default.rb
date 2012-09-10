require 'satellite/log'
require 'satellite/network/event'
require 'satellite/client/models/profile'
require 'satellite/extensions/core/string/inflections'
require 'satellite/extensions/core/object/underscored_class_name'

module Satellite
  module Client
    module Controllers
      class Default
        include Models

        attr_reader :events_to_send, :replace, :layout
        attr_accessor :input

        def initialize(options={})
          @events_to_send = []
        end

        # Internal: Step 1 of 3 of the Controller life-cycle.
        #           It gathers all messages from the server.
        #
        def process_event(event)
          if event.kind == :state && event.data != state && new_controller = Dispatcher.dispatch(event.data)
            #Log.debug "Got: #{event.data.inspect} VS. #{state.inspect}"
            switch new_controller
          else
            on_event(event)
          end
        end

        # Internal: Step 2 of 3 of the Controller life-cycle.
        #           It updates the universe.
        #
        def process_update
          @last_throttled_update ||= 0
          update
          if @last_throttled_update + 200 < Gosu.milliseconds
            @last_throttled_update = Gosu.milliseconds
            data = { gamertag: profile.gamertag, state: state }
            send_event :presence, OpenStruct.new(data)
            throttled_update
          end
        end

        # Internal: Step 3 of 3 of the Controller life-cycle.
        #           It draws the universe on the screen.
        #
        def draw
          layout.draw if layout
          layout.cursor.draw(mouse.x, mouse.y, 0) if layout && layout.cursor && mouse && mouse.x
        end

        def to_s
          "#<Controller #{state.inspect}>"
        end

        private

        # Internal: Convenience callback for subclasses.
        def on_event(event)
        end

        # Internal: Convenience callback for subclasses.
        def update
        end

        # Internal: Convenience callback for subclasses.
        def throttled_update
        end

        def switch(controller)
          @replace = controller
        end

        def send_event(kind, data=nil)
          events_to_send << Network::Event.new(kind: kind, data: data)
        end

        def mouse
          input.mouse if input
        end

        def keyboard
          input.keyboard if input
        end

        def state
          underscored_class_name
        end

        def profile
          @profile ||= Profile.new
        end

        def escape_exits!
          if keyboard.escape?
            send_event :leave
            switch Exit.new
            true
          end
        end

      end
    end
  end
end
