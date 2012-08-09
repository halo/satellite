require 'satellite/log'

module Satellite
  module Network
    class Pool

      def initialize(options={})
        @limit = options[:limit] || 256
        @remotes = {}
      end

      def <<(new_remote)
        unless new_remote.valid?
          Log.debug "Cannot register invalid remote #{new_remote.inspect}."
          return
        end
        if existing_remote = @remotes[new_remote.id]
          Log.debug "#{new_remote.id} already registerd."
          # remote.touch
        else
          Log.debug "Registering #{new_remote.id}..."
          @remotes[new_remote.id] = new_remote
          # remote.touch
        end
        true
      end

      def find(id)
        @remotes[id]
      end

      def remotes
        @remotes
      end

    end
  end
end