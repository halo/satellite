module Satellite
  module Server
    module Manager
      module Models
        class Pool
          attr_reader :data

          def initialize(options={})
            @data = {}
          end

          def <<(object)
            unless object.is_a?(object_class)
              Log.error "Received something which is not a #{object_class}: #{object.inspect}"
              return
            end
            data[object.id] = object
          end

          def delete(player_id)
            data.delete(player_id)
          end

        end
      end
    end
  end
end