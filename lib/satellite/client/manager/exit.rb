require 'satellite/client/manager/default'

module Satellite
  module Client
    module Manager
      class Exit < Default

        def update
          Client.window.close
          Log.info 'Bye.'
        end

      end
    end
  end
end
