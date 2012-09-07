require 'satellite/extensions/core/object/blank'
require 'optparse'

module Satellite
  module Client
    module Parameters
      extend self

      def id
        @@id ||= nil
      end

      def id=(object)
        @@id = object
      end

      def listen_port
        @@listen_port ||= nil
      end

      def listen_port=(object)
        @@listen_port = object
      end

      def screen_width
        @@screen_width ||= nil
      end

      def screen_width=(object)
        @@screen_width = object
      end

      def server_endpoint
        @@server_endpoint ||= nil
      end

      def server_endpoint=(object)
        @@server_endpoint = object
      end

      def server_port
        @@server_port ||= nil
      end

      def server_port=(object)
        @@server_port = object
      end

      def gamertag
        @@gamertag ||= nil
      end

      def gamertag=(object)
        @@gamertag = object
      end

    end
  end
end

OptionParser.new do |options|
  options.banner = "Usage: client [options]"

  options.on("--listen_port [PORT]", "Uhm, I don't know?") do |value|
    Satellite::Client::Parameters.listen_port = value
  end

  options.on("--screen_width [WIDTH]", "The width of the game window in pixels") do |value|
    Satellite::Client::Parameters.screen_width = value
  end

  options.on("--server_endpoint [ENDPOINT]", "The IP or Hostname of the server") do |value|
    Satellite::Client::Parameters.server_endpoint = value
  end

  options.on("--server_port [PORT]", "The port that the server is listening on") do |value|
    Satellite::Client::Parameters.server_port = value
  end

  options.on("--gamertag [GAMERTAG]", "Your player name") do |value|
    Satellite::Client::Parameters.gamertag = value
  end

  options.on("--id [ID]", "Your unique client ID") do |value|
    Satellite::Client::Parameters.id = value
  end
end.parse!
