require 'ipaddr'
require 'satellite/extensions/core/object/blank'

module Satellite
  module Network
    class Datagram

      attr_reader :payload, :endpoint, :port

      def initialize(options={})
        @payload = options[:payload]
        self.endpoint = options[:endpoint]
        self.port = options[:port]
      end

      def valid?
        endpoint && port
      end

      def to_s
        "#<#{ 'Invalid ' unless valid? }Datagram #{payload.inspect} #{endpoint.inspect}:#{port.inspect}>"
      end

      private

      def endpoint=(new_endpoint)
        @endpoint = begin
          IPAddr.new(new_endpoint.to_s.strip).to_s
        rescue ArgumentError
          # Invalid IP address
        end
      end

      def port=(new_port)
        @port = (new_port.to_i if (1024..65535).member?(new_port.to_i))
      end

    end
  end
end
