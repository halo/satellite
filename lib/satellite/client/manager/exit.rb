require 'satellite/client/manager/default'

module Satellite
  module Client
    module Manager
      class Exit < Default

        def update
          Client.window.close
        end

      end
    end
  end
end
