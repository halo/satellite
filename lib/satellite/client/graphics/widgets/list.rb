require 'satellite/client/graphics/text'
require 'satellite/client/graphics/widgets/default'

module Satellite
  module Client
    module Graphics
      module Widgets
        class List < Default
          attr_accessor :title, :records

          def initialize(options={})
            super
            @title = options[:title]
            @records = options[:records] || []
            @record_sprites_container = []
          end

          def objects
            [title_sprite] + record_sprites
          end

          def title_sprite
            @title_sprite ||= Text.new text: title, size: 5, x: @x, y: @y
          end

          def record_sprites
            records.each_with_index do |record, index|
              next if @record_sprites_container.detect { |sprite| sprite.text == record}
              sprite = Text.new(text: record, size: 4, x: @x)
              sprite.y = title_sprite.bottom + sprite.height * index + 1
              @record_sprites_container << sprite
            end
            @record_sprites_container.keep_if { |sprite| records.include?(sprite.text) }
            @record_sprites_container
          end

        end
      end
    end
  end
end