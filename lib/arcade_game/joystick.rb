require 'io/console'

module ArcadeGame
  # A joystick the user can control
  # A: left, S: neutral, D: right
  class Joystick
    POSITION_LEFT = 'a'.freeze
    POSITION_NEUTRAL = 's'.freeze
    POSITION_RIGHT = 'd'.freeze

    def initialize(manual = false)
      @position = POSITION_NEUTRAL
      @manual = manual
    end

    def manual?
      @manual == true
    end

    def position(paddle_x, ball_x)
      return manual_control if manual?

      ai_control(paddle_x, ball_x)
    end

    def ai_control(paddle_x, ball_x)
      return -1 if ball_x < paddle_x

      return 1 if ball_x > paddle_x

      0
    end

    def manual_control
      case STDIN.getch
      when POSITION_LEFT
        -1
      when POSITION_RIGHT
        1
      else
        0
      end
    end
  end
end
