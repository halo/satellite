require 'satellite/client/graphics/layouts/default'
require 'satellite/client/graphics/text'

module Satellite
  module Client
    module Graphics
      module Layouts
        class Loading < Default

          def objects
            [loading_widget]
          end

          def loading_widget
            @loading_widget ||= Widgets::Title.new text: 'Loading...'
          end

        end
      end
    end
  end
end