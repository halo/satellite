require 'gosu'

# See http://www.libgosu.org/cpp/namespace_gosu.html

module Satellite
  module Client
    module Input
      class State
        class Default
          include Gosu
          attr_reader :pressed

          MAPPING = {}

          def initialize
            @pressed = Set.new
            MAPPING.values.each do |key|
              define_method "#{key}?".to_sym do
                pressed.include? key
              end
            end
          end

          def button_down(gosu_key_id)
            if key = key(gosu_key_id)
              pressed << key
            end
          end

          def button_up(gosu_key_id)
            if key = key(gosu_key_id)
              pressed.delete key
            end
          end

          private

          def key(gosu_key_id)
            MAPPING[gosu_key_id]
          end

        end
      end
    end
  end
end