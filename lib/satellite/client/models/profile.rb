require 'satellite/extensions/core/object/blank'

module Satellite
  module Client
    module Models
      class Profile
        attr_reader :gamertag

        def initialize(options={})
          @gamertag = options[:gamertag] || Settings.gamertag
        end

      end
    end
  end
end