require 'satellite/client/controllers/lobby'
require 'satellite/client/controllers/briefing'
require 'satellite/client/controllers/loading'

module Satellite
  module Client
    module Controllers
      module Dispatcher

        def self.dispatch(state, options={})
          case state
          when :lobby    then Lobby.new options
          when :briefing then Briefing.new options
          when :loading  then Loading.new options
          when :exit     then Exit.new options
          end
        end

      end
    end
  end
end