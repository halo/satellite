require 'satellite/extensions/core/object/blank'

module Satellite
  module Network
    class Event

      # The unique ID of the sender or receiver
      attr_reader :receiver_id, :sender_id

      # An arbitrary payload
      attr_reader :data

      def initialize(options={})
        @receiver_id = options[:receiver_id].presence.to_s.strip
        @sender_id = options[:sender_id].presence.to_s.strip
        @kind = options[:kind]
        @data = options[:data]
      end

      def broadcast?
        receiver_id.blank?
      end

      # The "name" of this Event
      def kind
        @kind.present? ? @kind.to_s.to_sym : :undefined
      end

    end
  end
end