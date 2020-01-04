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
  end
end
