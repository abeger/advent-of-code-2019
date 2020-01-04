# frozen_string_literal: true

require_relative '../intcode'

module ArcadeGame
  # Represents an arcade game
  class Game
    attr_reader :screen

    def initialize(program)
      @screen = Screen.new
      @processor = Intcode::Computer.new(program)
    end

    def run
      current_output = :x_pos
      x = 0
      y = 0
      until @processor.finished?
        @processor.run do |output|
          case current_output
          when :x_pos
            x = output
            current_output = :y_pos
          when :y_pos
            y = output
            current_output = :tile_id
          when :tile_id
            print_tile(x, y, output)
            current_output = :x_pos
          end
        end
        # @processor.add_input(...) if @processor.waiting_for_input?
      end
    end

    def print_tile(x, y, tile_id)
      @screen.print_tile(x, y, tile_id)
    end
  end
end
