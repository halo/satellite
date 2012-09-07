require 'satellite/client/graphics/layouts/default'
require 'satellite/client/graphics/text'

module Satellite
  module Client
    module Graphics
      module Layouts
        class Loading < Default

          def objects
            [loading]
          end

          def loading
            @loading ||= Graphics::Text.new(text: 'Loading...', size: 4)
          end

        end
      end
    end
  end
end