require 'ipaddr'
require 'satellite/extensions/core/object/blank'

module Satellite
  module Network
    class Remote

      attr_reader :id, :endpoint, :port

      def initialize(options={})
        @id = options[:id].to_s.strip.presence
        self.endpoint = options[:endpoint]
        self.port = options[:port]
      end

      def valid?
        id && endpoint && port
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
