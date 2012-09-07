require 'gosu'
require 'satellite/network/client'
require 'satellite/client/settings'
require 'satellite/client/input/state'
require 'satellite/client/controllers/loading'

module Satellite
  module Client
    class Client < Gosu::Window

      # Internal: Convenience wrapper that makes it easier to stub the "global" window-variable in tests
      def self.window
        @@window
      end

      def initialize
        super Settings.screen_width, Settings.screen_height, false, 32
        @@window = self
        @network = Network::Client.new id: Settings.id, port: Settings.listen_port, server_endpoint: Settings.server_endpoint, server_port: Settings.server_port
        @input = Input::State.new
        @controller = Controllers::Loading.new
      end

      def start
        show
      end

      private

      def button_down(id)
        # update_mouse_position
        @input.button_down id
      end

      def button_up(id)
        # update_mouse_position
        @input.button_up id
      end

      def update
        receive_network_events
        update_input
        update_controller
        send_network_events
        switch_controller
      end

      def receive_network_events
        @network.receive_events do |event|
          @controller.process_event event
        end
      end

      def send_network_events
        while event = @controller.events_to_send.pop do
          @network.send_event event
        end
        @network.flush
      end

      def update_input
        @input.mouse_x = mouse_x.to_i
        @input.mouse_y = mouse_y.to_i
      end

      def update_controller
        #update_mouse_position
        @controller.input = @input
        @controller.process_update
      end

      def switch_controller
        if new_controller = @controller.replace
          Log.debug "Switching Controller: #{@controller} -> #{new_controller}"
          @controller = new_controller
        end
      end

      def draw
        @controller.draw
      end

    end
  end
end