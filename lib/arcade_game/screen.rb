# frozen_string_literal: true

module ArcadeGame
  # Represents the game's screen
  # 0,0 is the top left corner
  class Screen
    TILE_EMPTY = 0
    TILE_WALL = 1
    TILE_BLOCK = 2
    TILE_HORIZ_PADDLE = 3
    TILE_BALL = 4

    def initialize
      @screen = [[]]
      @max_x = 0
      @max_y = 0
    end

    def print_tile(x, y, tile_id)
      @screen[y] ||= []
      @screen[y][x] = tile_id
      @max_y = [y, @max_y].max
      @max_x = [x, @max_x].max
    end

    def num_tiles(tile_id)
      @screen.reduce(0) do |total, row|
        next total if row.nil?

        total + row.count(tile_id)
      end
    end

    def find_x(tile_id)
      @screen.each do |row|
        next if row.nil?

        pos = row.index(tile_id)
        return pos unless pos.nil?
      end
    end

    def print
      @screen.map do |row|
        next '' if row.nil?

        row.map do |tile_id|
          char(tile_id)
        end.join
      end.join("\n")
    end

    def char(tile_id)
      case tile_id
      when TILE_EMPTY
        ' '
      when TILE_WALL
        '|'
      when TILE_BLOCK
        '#'
      when TILE_HORIZ_PADDLE
        '-'
      when TILE_BALL
        'o'
      else
        ' '
      end
    end
  end
end
