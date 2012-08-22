require 'rubygems'
require 'gosu'

require 'satellite/client/graphics/object'
require 'satellite/client/window'

module Satellite
  module Client
    module Graphics
      class Text < Object
        attr_accessor :font, :text, :height

        def initialize(options={})
          super
          @text = options[:text] || 'text'
          @height = options[:height] || 30
          @font = default_font
        end

        def draw
          font.draw(text, x, y, z)
        end

        def window
          Window.main
        end

        def default_font
          Gosu::Font.new(window, "assets/fonts/orbitron/orbitron-medium.ttf", height)
        end

      end
    end
  end
end