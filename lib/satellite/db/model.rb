require 'satellite/db/store'
require 'satellite/extensions/core/object/random'

module Satellite
  module DB
    class Model

      @@db = {}

      attr_reader :id

      def initialize(options={})
        @id = options[:id] || random_id
      end

      def self.create(options={})
        self.new(options).save
      end

      def self.find(id)
        @@db[id]
      end

      def self.destroy(id)
        @@db.delete(id)
      end

      def self.all(&block)
        if block_given?
          @@db.values.each { |record| yield record }
        else
          @@db.values
        end
      end

      def save
        @@db[self.id] = self
      end

      def destroy
        @@db.delete(self.id)
      end

      def destroy_all
        @@db.each_value { |object| object.destroy }
      end

    end
  end
end