require 'satellite/log'
require 'satellite/server/controllers/meeting'

module Satellite
  module Server
    module Controllers
      class Briefing < Meeting
        attr_reader :creator_id

        def initialize(options={})
          super
          @creator_id = options[:creator_id]
        end

        def on_event(event)
          super
          player = players.find(event.sender_id)
          case event.kind
          when :ready
            Log.debug "#{player.gamertag} says READY"
            player.ready = true unless player.ready?
          when :unready
            Log.debug "#{player.gamertag} says UNREADY"
            player.ready = false if player.ready?
          when :start_game
            Log.debug "#{player.gamertag} says START_GAME"
            if all_ready? && event.sender_id == creator_id
              switch Loading.new
            end
          end
        end

        def update
          creator = players.find(creator_id)
          creator.ready = true if creator
          Log.debug "players: #{players.inspect}"
          super
          players.all.each do |receiver|
            list = players.all.map do |player|
              export = player.to_hash :gamertag, :ready
              export.merge!({ you: receiver.id == player.id })
              created_game = creator_id == player.id
              export.merge!({ created_game: created_game, can_start_game: (all_ready? && created_game), can_be_ready: !created_game })
            end
            send_event receiver.id, :players, list
          end
        end

        def all_ready?
          players.all.all?(&:ready?)
        end

      end
    end
  end
end