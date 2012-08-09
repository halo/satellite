require 'socket'
require 'satellite/network/datagram'
require 'satellite/log'

module Satellite
  module Network
    class GameSocket

      def initialize(options={})
        @preferred_port = options[:preferred_port]
        @random_port_tries = options[:random_port_tries] || 5
        reset!
        start!
      end

      # Public: Identifies the port we're currently listening on.
      #
      # Returns: An Integer representing the port we're bound to, or nil if not bound at all.
      def port
        @socket.connect_address.ip_port
      rescue SocketError
        # Not bound to any local port
      rescue IOError
        # Socket has been closed
      end

      # Public: Resets the listening port.
      def port=(new_port)
        return if new_port == port
        reset!
        @desired_port = new_port
        start!
      end

      # Public: Sends a single Datagram to the socket.
      #
      # Returns the number of bytes sent or false if nothing was sent.
      # Raises... all sorts of things.
      def send_datagram(datagram)
        return false unless datagram.is_a?(Datagram)
        return false unless datagram.valid?
        return unless datagram.payload.to_s.present?
        bytes_sent = @socket.send datagram.payload.to_s, 0, datagram.endpoint, datagram.port
      rescue Errno::EHOSTUNREACH
        Log.warn "Cannot find a route to host #{datagram.endpoint.inspect}."
        false
      end

      def receive_datagrams
        while datagram = receive_datagram
          yield datagram
        end
      end

      def flush
        @socket.flush
      end

      # Internal: Free the socket and reset all settings. Useful for testing.
      def reset!
        BasicSocket.do_not_reverse_lookup = true
        @desired_port = preferred_port
        begin
          @socket.close if @socket
        rescue IOError
          # Already closed
        end
        @socket = UDPSocket.new
      end

      # Internal: Start listening on a socket. Useful for testing.
      def start!
        ports = ports_to_try
        Log.debug "Trying ports #{ports.inspect}..."
        until port || !(try_port = ports.shift)
          begin
            Log.debug "Trying to listen on port #{try_port}..."
            @socket.bind('0.0.0.0', try_port)
            Log.info "Successfully listening on port #{try_port}..."
          rescue Errno::EADDRINUSE, Errno::EINVAL
            Log.warn "Port #{try_port} occupied, trying another..."
          end
        end
        Log.error "Could not find any port to listen on..." unless port
      end

      private

      def receive_datagrams!
        while datagram = receive_datagram
          yield datagram
        end
      end

      # Internal: Fetches a single packet from the socket.
      #
      # Returns a Datagram or nil if there is nothing (valid) avaliable.
      # Raises... all sorts of things.
      def receive_datagram
        return unless IO.select([@socket], nil, nil, 0)
        data = @socket.recvfrom_nonblock(65507)
        datagram = Datagram.new payload: data[0], endpoint: data[1][3], port: data[1][1]
        datagram.valid? ? datagram : nil
      end

      # Internal: The priority of ports to try
      def ports_to_try
        result = [@desired_port, preferred_port].uniq
        @random_port_tries.times { |i| result << random_port }
        result
      end

      # Internal: Returns the official Satellite default game port.
      def preferred_port
        @preferred_port
      end

      # Internal: Returns a random port number. See RFC6335 for valid port ranges.
      def random_port
        rand(1024..49151)
      end

#      def punch(local_port, remote)
#        puncher = UDPSocket.new
#        puncher.bind nil, local_port
#        puncher.send '', 0, remote.endpoint, remote.port
#        puncher.close
#      end

    end
  end
end