# frozen_string_literal: true

require_relative '../lib/intcode'

# Orbit Mapping methods
module OrbitMap
  class Map
    def initialize(map_string)
      @map_string = map_string
    end

    def checksum
      map.each_value.sum do |planet|
        planet.orbit_count
      end
    end

    def map
      @map ||= build_map
    end

    def build_map
      map_hash = map_string.map do |orbit|
        ids = orbit.split(')')
        [ids[1], Planet.new(ids[1], ids[0], self)]
      end.to_h
      map_hash['COM'] = CenterOfMass.new
      map_hash
    end

    def find(planet_id)
      map[planet_id]
    end

    private

    attr_reader :map_string
  end

  class Planet
    attr_reader :id

    def initialize(id, orbited_id, map)
      @id = id
      @orbited_id = orbited_id
      @map = map
    end

    def orbit_count
      @orbit_count ||= orbited.orbit_count + 1
    end

    def orbit_tree
      @orbit_tree ||= [@orbited_id] + orbited.orbit_tree
    end

    def orbit_hop(dest_id)
      dest_tree = map.find(dest_id).orbit_tree
      orbit_tree.each_with_index do |planet_id, ind|
        dest_ind = dest_tree.find_index(planet_id)
        next if dest_ind.nil?

        return ind + dest_ind
      end
      0
    end

    def orbited
      map.find(@orbited_id)
    end

    private

    attr_reader :map
  end

  class CenterOfMass
    def orbit_count
      0
    end

    def orbit_tree
      []
    end
  end
end

if ARGV.count < 1
  puts 'Usage: ruby orbit_count.rb <input_file>'
  exit
end

map_text = File.readlines(ARGV[0]).map(&:strip)

map = OrbitMap::Map.new(map_text)
puts 'Checksum: ' + map.checksum.to_s

puts 'Hops: ' + map.find('YOU').orbit_hop('SAN').to_s
