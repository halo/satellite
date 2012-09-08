require 'ostruct'
require 'satellite/server/combat/space'
require 'satellite/server/combat/field'
require 'satellite/server/combat/object/car'
require 'satellite/server/combat/player'
require 'satellite/server/combat/camera'
require 'satellite/server/controllers/default'

module Satellite
  module Server
    module Controllers
      class Combat < Default
        attr_reader :events_to_send

        def initialize(options={})
          super
          @players = options[:players]
          @space = Space.new
        end

        def on_event(id, name, data)
          Log.debug "Received event #{name} by #{id}: #{data.inspect}"
          player = players.find(id)
          case name
          when :leave
            if player
              @space.delete player.object
              player.destroy
              @events_to_send << Event.new(name: :leave, data: player.export)
            end
          when :join
            if player
              Log.info "Player #{id} re-joined the game."
            else
              object = Object::Car.new
              object.warp(CP::Vec2.new(100 + (@space.objects.size * 50), 200))
              @space << object
              Log.info "Adding Player #{id} with object #{object.id}..."
              Player.create id: id, object: object
            end
          when :button_down
            player.button_down(data) if player
          when :button_up
            player.button_up(data) if player
          else
            puts "Unknown event #{name.inspect} by #{id} with data #{data.inspect}"
          end
        end

        def update
          @events_to_send = []
          update_space
          enqueue_fields
        end

        def update_space
          # For accuracy, the physics update 5 times more often than the OpenGL view.
          5.times do
            update_space!
          end
        end

        def update_space!
          Player.all do |player|
            object = player.object
            object.shape.body.reset_forces

            if player.holding? :left
              object.turn_left
            elsif player.holding? :right
              object.turn_right
            end

            unless player.holding?(:left) || player.holding?(:right)
              delta = 0.005
              if object.shape.body.w > 0
                object.shape.body.w -= delta
              elsif object.shape.body.w < 0
                object.shape.body.w += delta
              end
            end

            if player.holding? :up
              object.accelerate
            elsif player.holding? :down
              object.reverse
            end
          end
          @space.advance
        end

        def enqueue_fields
          Player.all do |player|
            field = Field.new
            @space.objects.each do |object|
              field << object
            end
            field.camera = Camera.new(object: player.object)
            send_event player.id, :field, field.export
          end
        end

      end
    end
  end
end