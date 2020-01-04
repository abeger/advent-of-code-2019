# frozen_string_literal: true

require_relative '../intcode'

module PaintingRobot
  # Represents the painting robot
  class Robot
    attr_reader :heading
    attr_reader :hull

    HEADING_UP = 0
    HEADING_RIGHT = 90
    HEADING_DOWN = 180
    HEADING_LEFT = 270

    MOVE_LEFT = 0
    MOVE_RIGHT = 1

    def initialize(program)
      @hull = PaintingRobot::Hull.new
      @heading = HEADING_UP
      @processor = Intcode::Computer.new(program)
    end

    def turn_right
      turn_degrees(90)
    end

    def turn_left
      turn_degrees(-90)
    end

    def move_forward
      case @heading
      when HEADING_LEFT
        @hull.move_left
      when HEADING_RIGHT
        @hull.move_right
      when HEADING_UP
        @hull.move_up
      when HEADING_DOWN
        @hull.move_down
      end
    end

    def move(command)
      if command == MOVE_LEFT
        turn_left
      else
        turn_right
      end
      move_forward
    end

    def paint(color)
      @hull.current_location.paint(color)
    end

    def run
      current_output = :paint
      until @processor.finished?
        @processor.run do |output|
          if current_output == :paint
            paint(output)
            current_output = :move
          else
            move(output)
            current_output = :paint
          end
        end
        @processor.add_input(@hull.current_location.color) if @processor.waiting_for_input?
      end
    end

    private

    def turn_degrees(deg)
      @heading = (@heading + deg) % 360
    end
  end
end
