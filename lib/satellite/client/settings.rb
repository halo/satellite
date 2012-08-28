module Satellite
  module Client
    module Settings
      extend self

      def listen_port
        33033
      end

      def screen_width
        1280
        1024
        640
      end

      def screen_height
        800
        640
        480
      end

      def server_endpoint
        '127.0.0.1'
      end

      def server_port
        33033
      end

    end
  end
end