require 'ostruct'
require 'satellite/network/connection'
require 'satellite/network/remote'
require 'satellite/extensions/core/object/blank'
require 'satellite/extensions/core/object/random'

module Satellite
  module Network
    class Client < Connection
      attr_reader :id, :key, :remote

      def initialize(options={})
        @id = options[:id] || random_id
        @remote = Remote.new endpoint: options[:server_endpoint], port: options[:server_port]
        Log.debug "My server is #{@remote.endpoint}:#{@remote.port}."
        super
      end

      def send_event(options={})
        event_name = options[:event_name]
        data = options[:data]
        #Log.debug "Sending #{event_name} to #{remote.endpoint}:#{remote.port}"
        payload = Marshal.dump({ id: id, event_name: event_name, data: data })
        @socket.send_datagram Datagram.new endpoint: remote.endpoint, port: remote.port, payload: payload
      end

      def receive_events
        @socket.receive_datagrams do |datagram|
          payload = Marshal.load(datagram.payload)
          yield payload[:event_name], payload[:data]
        end
      end

    end
  end
end