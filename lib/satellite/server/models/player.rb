require 'satellite/db/model'

module Satellite
  module Server
    module Models
      class Player < Satellite::DB::Model
        attr_reader :keys
        attr_accessor :object

        def initialize(options={})
          super
          @keys = {}
          @object = options[:object]
        end

        def holding?(key)
          !!keys[key]
        end

        def button_down(key)
          keys[key] = true
        end

        def button_up(key)
          keys.delete(key)
        end

      end
    end
  end
end