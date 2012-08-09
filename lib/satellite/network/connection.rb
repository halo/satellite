require 'satellite/network/game_socket'

module Satellite
  module Network
    class Connection

      def initialize(options={})
        @socket = GameSocket.new preferred_port: options[:port]
      end

      def port
        @socket.port
      end

      def port=(new_port)
        @socket.port = new_port
      end

      def flush
        @socket.flush
      end

      # Internal: Free the socket. Useful for testing.
      def reset!
        @socket.reset!
      end

      # Internal: Start listening on the socket. Useful for testing.
      def start
        @socket.start!
      end

    end
  end
end