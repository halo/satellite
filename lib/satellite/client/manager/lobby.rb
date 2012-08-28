require 'satellite/client/manager/default'
require 'satellite/client/manager/exit'
require 'satellite/network/event'
require 'satellite/client/graphics/sprite'
require 'satellite/client/graphics/text'

module Satellite
  module Client
    module Manager
      class Lobby < Default

        def on_event(event)
        end

        def update
        end

        def draw
          Graphics::Text.new(text: 'Welcome to Satellite').draw
        end

        def button_up(key)
          if key == :escape
            events_to_send << Network::Event.new(kind: :leave)
            switch Exit.new
          end
        end

      end
    end
  end
end