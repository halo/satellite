require 'satellite/client/controllers/default'
require 'satellite/client/controllers/dispatcher'
require 'satellite/client/graphics/layouts/loading'
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
          send_event :loading
        end

        def update
          return if escape_exits!
        end

        def layout
          @layout ||= Satellite::Client::Graphics::Layouts::Loading.new
        end

      end
    end
  end
end