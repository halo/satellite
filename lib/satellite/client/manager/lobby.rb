require 'satellite/client/manager/default'
require 'satellite/client/manager/exit'
require 'satellite/client/graphics/layout/lobby'

module Satellite
  module Client
    module Manager
      class Lobby < Default

        def on_event(event)
          Log.debug "Got event: #{event.inspect}"
          case event.kind
          when :players_in_lobby
            layout.player_names = event.data
          end
        end

        def on_input(input)
          case input.to_sym
          when :mouse_single_click then Log.debug "Mouse single clicked"
          when :mouse_double_click then Log.debug "Mouse double clicked"
          when :mouse_left         then 'asd'
          end
        
          if input.key.escape?
          end
          if input.mouse.click?
            Log.debug "Mouse single clicked"
          end
          if input.mouse.double_click?
            Log.debug "Mouse double clicked"
          end
          if input.mouse.rect?
            Log.debug "Mouse rectangle: #{input.mouse.rect}"
          end
        end

        def on_update
          if update_intervals % 30 == 0
            send_event :in_lobby, gamertag: Client.profile.gamertag
          end
        end

        def layout
          @layout ||= Satellite::Client::Graphics::Layout::Lobby.new
        end

        #def button_down(key, mouse_x, mouse_y)
        #  Log.debug "DOWN: #{key.inspect} (#{mouse_x}x#{mouse_y})"
        #end
        #
        #def button_up(key)
        #  Log.debug "UP: #{key.inspect}"
        #  if key == :escape
        #    send_event :leave
        #    switch Exit.new
        #  end
        #end

      end
    end
  end
end