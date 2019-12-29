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
    end

    def to_s
      "(#{x}, #{y})"
    end

    def visible(asteroids)
      visible_hash(asteroids).keys.size
    end

    def destruction_order(asteroids)
      # Sort'em
      sorted_hash = visible_hash(asteroids)
      sorted_hash.keys.each do |dir|
        sorted_hash[dir].sort_by! do |ast_hash|
          ast_hash[:distance]
        end
      end

      destruction_list = []
      until sorted_hash.empty?
        sorted_hash.keys.sort.each do |dir|
          destruction_list << sorted_hash[dir].shift[:asteroid]
          sorted_hash.delete(dir) if sorted_hash[dir].empty?
        end
      end
      destruction_list
    end

    # Calculate direction from this asteroid to another.
    # north = 0, south =180, east = 90, west = 270
    def direction(asteroid)
      # Negative y makes the rotation clockwise
      degrees = Math.atan2((asteroid.y - y), (asteroid.x - x)) * 180 / Math::PI
      # Adding 90 puts 0 at "north"
      # Modding by 360 removes negatives & greater than 360
      (degrees + 90) % 360
    end

    def distance(asteroid)
      Math.sqrt((asteroid.y - y)**2 + (asteroid.x - x)**2)
    end

    def <=>(other)
      return other.x <=> x unless other.x == x

      other.y <=> y
    end

    private

    def visible_hash(asteroids)
      vis_hash = Hash.new { |h, k| h[k] = [] }
      asteroids.each do |ast|
        next if ast == self # skip yourself

        vis_hash[direction(ast)] << { asteroid: ast, distance: distance(ast) }
      end
      vis_hash
    end
  end
end
