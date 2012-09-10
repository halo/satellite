require 'satellite/client/controllers/lobby'
require 'satellite/client/controllers/briefing'
require 'satellite/client/controllers/loading'
require 'satellite/client/controllers/exit'
require 'satellite/client/controllers/combat'

module Satellite
  module Client
    module Controllers
      module Dispatcher

        def self.dispatch(state)
          case state
          when :lobby    then Lobby.new
          when :briefing then Briefing.new
          when :loading  then Loading.new
          when :exit     then Exit.new
          when :combat   then Combat.new
          end
        end

      end
    end
  end
end