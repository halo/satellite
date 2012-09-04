require 'satellite/client/controllers/default'

module Satellite
  module Client
    module Controllers
      class Exit < Default

        def update
          Client.window.close
          Log.info 'Bye.'
        end

      end
    end
  end
end
