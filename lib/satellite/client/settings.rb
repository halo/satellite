require 'satellite/extensions/core/object/blank'
require 'satellite/client/parameters'
require 'satellite/client/superhero'
require 'satellite/extensions/core/object/random'

module Satellite
  module Client
    module Settings
      extend self

      def id
        Parameters.id.presence || random_id
      end

      def gamertag
        Parameters.gamertag.presence  || @@gamertag ||= Superhero.pick
      end

      def listen_port
        Parameters.listen_port.presence || 33033
      end

      def screen_width
        Parameters.screen_width.presence || 640
      end

      def screen_height
        (screen_width / 1.6).to_i
      end

      def server_endpoint
        Parameters.server_endpoint.presence || '127.0.0.1'
      end

      def server_port
        Parameters.server_port.presence || 33033
      end

    end
  end
end