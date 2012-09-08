require 'ostruct'
require 'satellite/db/store'
require 'satellite/extensions/core/object/random'
require 'satellite/extensions/core/string/inflections'
require 'satellite/extensions/core/object/underscored_class_name'

module Satellite
  module DB
    class Model
      extend Enumerable

      attr_reader :id

      def initialize(options={})
        @id = options[:id] || random_id
      end

      def self.create_or_update(options={})
        if record = find(options[:id])
          record.update(options)
        else
          create options
        end
      end

      def self.create(options={})
        self.new(options).save
      end

      def self.find(id)
        table[id]
      end

      def self.destroy(id)
        table.delete(id)
      end

      def self.destroy_all
        table.clear
      end

      def self.each(&block)
        if block_given?
          table.values.each { |record| yield record }
        else
          table.values
        end
      end

      def self.all(*args, &block)
        each(*args, &block)
      end

      def self.last
        all.last
      end

      def save
        table[self.id] = self
      end

      def update(options={})
        options.each do |key, value|
          update_attribute(key, value)
        end
      end

      def destroy
        table.delete(self.id)
      end

      def self.export(*args)
        all.map { |record| record.export(*args) }
      end

      def export(*only_attributes)
        hash = attributes
        hash.select! { |key, value| only_attributes.include?(key) } unless only_attributes.empty?
        OpenStruct.new hash
      end

      def read_attribute(name)
        instance_variable_get '@'.concat(name.to_s).to_sym
      end

      def update_attribute(name, value)
        instance_variable_set '@'.concat(name.to_s).to_sym, value
      end

      private

      def attributes
        attribute_names.inject({}) { |result, name| result[name] = read_attribute(name); result }
      end

      def attribute_names
        instance_variables.map do |instance_variable|
          instance_variable.to_s.gsub('@', '').to_sym
        end
      end

      def table
        Store.table(self.class.table_name)
      end

      def self.table
        Store.table(table_name)
      end

      def self.table_name
        underscored_class_name
      end

    end
  end
end