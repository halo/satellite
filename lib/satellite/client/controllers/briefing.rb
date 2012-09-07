require 'satellite/client/controllers/default'
require 'satellite/client/controllers/exit'
require 'satellite/client/graphics/layouts/lobby'

module Satellite
  module Client
    module Controllers
      class Briefing < Default

        def on_event(event)
          Log.debug "Got event: #{event.inspect}"
        end

        def update
          return if escape_exits!

        end

        def layout
          @layout ||= Satellite::Client::Graphics::Layouts::Briefing.new
        end

      end
    end
  end
end