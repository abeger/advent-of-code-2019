# frozen_string_literal: true

module MonitoringStation
  # Asteroid map
  class Map
    def initialize(map_text)
      @map_text = map_text
    end

    def asteroids
      @asteroids ||= load_asteroids
    end

    def best_station_location
      asteroids.max_by(&:visible_asteroids)
    end

    private

    def load_asteroids
      asteroids = parse_map

      asteroids.size.times do |a1|
        asteroids.size.times do |a2|
          asteroids[a1].add_asteroid(asteroids[a2])
        end
      end

      asteroids
    end

    def parse_map
      @map_text.each_line.each_with_index.map do |row, y|
        row.strip.each_char.each_with_index.map do |cell, x|
          next MonitoringStation::Asteroid.new(x, y) if cell == '#'

          nil
        end.compact
      end.flatten
    end
  end
end
