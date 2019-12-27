# frozen_string_literal: true

module MonitoringStation
  # Represents an asteroid at a specific spot
  class Asteroid

    include Comparable

    attr_reader :x, :y
    attr_reader :asteroid_hash

    def initialize(x, y)
      @x = x
      @y = y
      @asteroid_hash = {}
    end

    def to_s
      "(#{x}, #{y})"
    end

    def add_asteroid(asteroid)
      return if asteroid == self

      @asteroid_hash[asteroid] = direction(asteroid)
    end

    def visible_asteroids
      @asteroid_hash.values.uniq.size
    end

    # Calculate direction from this asteroid to another.
    # Return special strings if horizontal/vertical
    # :hl/:hr (left/right)
    # "vu/:vd (up/down
    def direction(asteroid)
      Math.atan2((asteroid.y - y), (asteroid.x - x))
    end

    def <=>(other)
      return other.x <=> x unless other.x == x

      other.y <=> y
    end
  end
end
