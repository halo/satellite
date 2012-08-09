module Satellite
  module Client
    module Settings
      extend self

      def listen_port
        33033
      end

      def screen_width
        1280
        640
      end

      def screen_height
        800
        480
      end

      def server_endpoint
        '127.0.0.1'
        #'109.239.49.100'
      end

      def server_port
        33033
      end

    end
  end
end