# frozen_string_literal: true

require_relative '../intcode'

module ArcadeGame
  # Represents an arcade game
  class Game
    attr_reader :screen, :score

    OUTPUT_X = 0
    OUTPUT_Y = 1
    OUTPUT_TILE_ID = 2

    def initialize(program, free_play = false, display = false)
      @screen = Screen.new
      @processor = Intcode::Computer.new(program)
      @free_play = free_play
      @joystick = Joystick.new
      @score = 0
      @display = display
      reset
    end

    def free_play?
      @free_play == true
    end

    def display?
      @display == true
    end

    def run
      until @processor.finished?
        @processor.run do |output|
          case @current_output
          when OUTPUT_X
            @x = output
          when OUTPUT_Y
            @y = output
          when OUTPUT_TILE_ID
            process_output(@x, @y, output)
            print_tile(@x, @y, output)
          end
          @current_output = (@current_output + 1) % 3
        end
        print_screen if display?
        @processor.add_input(@joystick.position(paddle_x, ball_x)) if @processor.waiting_for_input?
      end
    end

    def reset
      @current_output = OUTPUT_X
      @processor.reset
      @processor.write(0, 2) if free_play?
    end

    def process_output(x, y, value)
      if x == -1 && y.zero?
        update_score(value)
      else
        print_tile(x, y, value)
      end
    end

    def print_tile(x, y, tile_id)
      @screen.print_tile(x, y, tile_id)
    end

    def update_score(value)
      @score = value
    end

    def print_screen
      puts 'SCORE: ' + score.to_s
      puts "BALL: #{ball_x} PADDLE: #{paddle_x}"
      puts @screen.print
    end

    def paddle_x
      @screen.find_x(Screen::TILE_HORIZ_PADDLE)
    end

    def ball_x
      @screen.find_x(Screen::TILE_BALL)
    end
  end
end
