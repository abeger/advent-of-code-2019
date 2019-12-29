# frozen_string_literal: true

module MonitoringStation
  # Asteroid map
  class Map
    def initialize(map_text)
      @map_text = map_text
    end

    def asteroids
      @asteroids ||= parse_map
    end

    def best_station_location
      @best_station_location ||= find_best_station_location
    end

    private

    def find_best_station_location
      asteroids.max_by do |loc|
        loc.visible(asteroids)
      end
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
