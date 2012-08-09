require 'satellite/network/connection'
require 'satellite/network/remote'
require 'satellite/network/pool'
require 'satellite/log'

module Satellite
  module Network
    class Server < Connection

      def initialize(options={})
        super
        @pool = Pool.new
      end

      def send_event(options={})
        event_name = options[:event_name]
        data = options[:data]
        id = options[:id]
        unless remote = @pool.find(id)
          Log.debug "Remote #{id.inspect} not found. I have #{@pool.remotes.inspect}"
          return
        end
        #Log.debug "Found #{id.inspect}."
        payload = Marshal.dump({ event_name: event_name, data: data })
        #Log.debug "Sending to #{remote.port}"
        @socket.send_datagram Datagram.new endpoint: remote.endpoint, port: remote.port, payload: payload
      end

      def broadcast(options={})
        event_name = options[:event_name]
        data = options[:data]
        remotes.values.each do |remote|
          send_event id: remote.id, event_name: event_name, data: data
        end
      end

      def receive_events
        @socket.receive_datagrams do |datagram|
          payload = Marshal.load(datagram.payload)
          @pool << Remote.new(id: payload[:id], endpoint: datagram.endpoint, port: datagram.port)
          yield payload[:id], payload[:event_name], payload[:data]
        end
      end

      def remotes
        @pool.remotes
      end

    end
  end
end