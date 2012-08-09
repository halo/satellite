require 'satellite/extensions/core/object/blank'

module Satellite
  module Server
    class Event
      attr_reader :id, :player_id, :name, :data

      def initialize(options={})
        @player_id = options[:player_id]
        @name = options[:name]
        @data = options[:data]
      end

      def broadcast?
        player_id.blank?
      end

    end
  end
end