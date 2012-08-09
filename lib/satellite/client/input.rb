require 'gosu'

# See http://www.libgosu.org/cpp/namespace_gosu.html

module Satellite
  module Input
    extend self
    include Gosu

    MAPPING = {
      KbLeft   => :left,
      KbRight  => :right,
      KbUp     => :up,
      KbDown   => :down,
      KbEscape => :escape,
    }

    def key(gosu_key_id)
      MAPPING[gosu_key_id]
    end

  end
end