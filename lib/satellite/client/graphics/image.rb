require 'rubygems'
require 'gosu'

module Satellite
  module Client
    module Graphics
      class Image

        def initialize(options={})
          name = options[:name]
          @image = Gosu::Image.new(window, "assets/#{name}", false)
        end

        def window
          Client.window
        end

        def draw_rot(*args)
          @image.draw_rot(*args)
        end

        def draw(*args)
          @image.draw(*args)
        end

      end
    end
  end
end