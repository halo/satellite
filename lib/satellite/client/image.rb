require 'rubygems'
require 'gosu'

module Satellite
  class Image

    def initialize(options={})
      name = options[:name]
      @image = Gosu::Image.new(window, "assets/#{name}", false)
    end

    def window
      $window
    end

    def draw_rot(*args)
      @image.draw_rot(*args)
    end

  end
end