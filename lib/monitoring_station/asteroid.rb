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
    def direction(asteroid)
      # Negative y makes the rotation clockwise
      degrees = Math.atan2((y - asteroid.y), (asteroid.x - x)) * 180 / Math::PI
      # Adding 90 puts 0 at "north"
      (degrees + 90) % 360
    end

    def distance(asteroid)
      Math.sqrt((asteroid.y - y)**2 + (asteroid.x - x)**2)
    end

    def <=>(other)
      return other.x <=> x unless other.x == x

      other.y <=> y
    end
  end
end
