require 'satellite/client/graphics/text'
require 'satellite/client/graphics/widgets/default'

module Satellite
  module Client
    module Graphics
      module Widgets
        class Title < Default
          attr_reader :text

          def initialize(options={})
            super
            @text = options[:text]
            @x = default_x
            @y = default_y
          end

          def objects
            [title]
          end

          def title
            @title ||= Text.new text: text, size: 5, x: @x, y: @y
          end

        end
      end
    end
  end
end