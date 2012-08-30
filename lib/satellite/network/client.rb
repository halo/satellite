require 'ostruct'
require 'satellite/extensions/core/object/blank'
require 'satellite/extensions/core/object/random'
require 'satellite/network/connection'
require 'satellite/network/event'
require 'satellite/network/remote'

module Satellite
  module Network
    class Client < Connection
      attr_reader :remote

      def initialize(options={})
        @remote = Remote.new endpoint: options[:server_endpoint], port: options[:server_port]
        Log.debug "My server is #{@remote.endpoint}:#{@remote.port}."
        super
      end

      def send_event(event)
        unless event.is_a?(Event)
          Log.error "Network stack received invalid event from client: #{event.inspect}"
          return
        end
        payload = Marshal.dump({ sender_id: id, kind: event.kind, data: event.data })
        @socket.send_datagram Datagram.new endpoint: remote.endpoint, port: remote.port, payload: payload
      end

      def receive_events
        receive_remotes_and_payloads do |remote, payload|
          yield Event.new sender_id: remote.id, kind: payload[:kind], data: payload[:data]
        end
      end

    end
  end
end