require 'rubygems'
require 'gosu'

require 'satellite/client/graphics/object'
require 'satellite/client/client'

module Satellite
  module Client
    module Graphics
      class Text < Object
        attr_accessor :font, :text, :size
        attr_writer :height

        def initialize(options={})
          super
          @text = options[:text] || 'text'
          @height = options[:height]
          @size = options[:size] || 3
          @font = default_font
        end

        def draw
          font.draw(text, x, y, z)
        end

        def window
          Client.window
        end

        def height
          if @height
            # Fixed height in pixels
            @height.to_i
          else
            # Height relative to window height
            (Settings.screen_height.to_f * (@size.to_f / 100.0)).to_i
          end
        end

        def default_font
          Gosu::Font.new(window, "assets/fonts/orbitron/orbitron-medium.ttf", height)
        end

      end
    end
  end
end