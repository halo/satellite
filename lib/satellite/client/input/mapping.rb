require 'gosu'

# See http://www.libgosu.org/cpp/namespace_gosu.html

module Satellite
  module Client
    module Input
      module Mapping
        extend self
        include Gosu

        MAPPING = {
          KbLeft   => :left,
          KbRight  => :right,
          KbUp     => :up,
          KbDown   => :down,
          KbEscape => :escape,
          MsLeft   => :mouse_left,
          MsRight  => :mouse_right,
        }

        def key(gosu_key_id)
          MAPPING[gosu_key_id]
        end

      end
    end
  end
end