# frozen_string_literal: true

module OrbitMap
  # A map of planets and their orbits
  class Map
    def initialize(map_array)
      @map_array = map_array
    end

    def checksum
      map.each_value.sum(&:orbit_count)
    end

    def map
      @map ||= build_map
    end

    def build_map
      map_hash = map_array.map do |orbit|
        ids = orbit.strip.split(')')
        [ids[1], Planet.new(ids[1], ids[0], self)]
      end.to_h
      map_hash['COM'] = CenterOfMass.new
      map_hash
    end

    def find(planet_id)
      map[planet_id]
    end

    private

    attr_reader :map_array
  end
end
