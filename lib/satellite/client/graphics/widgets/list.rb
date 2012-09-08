require 'satellite/client/graphics/text'
require 'satellite/client/graphics/widgets/default'

module Satellite
  module Client
    module Graphics
      module Widgets
        class List < Default
          attr_accessor :title
          attr_reader :records

          def initialize(options={})
            super
            @title = options[:title]
            @records = options[:records] || []
            @record_sprites_container = []
          end

          def objects
            [title_sprite, record_sprites]
          end

          def title_sprite
            @title_sprite ||= Text.new text: text, size: 4, x: @x, y: @y
          end

          def record_sprites
            i = 0
            @record_sprites_container.keep_if { |sprite| records.include?(sprite.text) }
            records.sort.map do |record|
              i += 1
              if sprite = @record_sprites_container.detect(&:text)
                sprite
              else
                sprite = Text.new(text: record, size: 4, x: @x)
                sprite.y = sprite.height * i
                @record_sprites_container << sprite
              end
            end
          end

        end
      end
    end
  end
end