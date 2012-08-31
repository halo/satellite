require 'satellite/client/input/state/device'

module Satellite
  module Client
    module Input
      class State
        class Mouse < Device

          MAPPING = {
            MsLeft   => :left,
            MsRight  => :right,
          }


        end
      end
    end
  end
end