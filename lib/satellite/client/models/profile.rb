module Satellite
  module Client
    module Models
      class Profile
        attr_reader :gamertag

        def initialize(options={})
          @gamertag = options[:gamertag] || 'Bob'
        end

      end
    end
  end
end