require 'gosu'

module Satellite
  module Client
    class Window < Gosu::Window

      def initialize(*args)
        super
        @@window = self
      end

      # Internal: Convenience wrapper that makes it easier to stub the "global" window-variable in tests
      def self.window
        @@window
      end

    end
  end
end