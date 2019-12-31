# frozen_string_literal: true

module PaintingRobot
  # A panel of the hull
  class Panel
    COLOR_BLACK = 0
    COLOR_WHITE = 1
    DEFAULT_COLOR = COLOR_BLACK

    attr_reader :color
    attr_reader :id

    def initialize
      @color = DEFAULT_COLOR
      @painted = false
    end

    def paint(color)
      @color = color
      @painted = true unless painted?
    end

    def painted?
      @painted
    end

    def print
      case color
      when COLOR_WHITE
        '#'
      when COLOR_BLACK
        ' '
      else
        '?'
      end
    end
  end
end
