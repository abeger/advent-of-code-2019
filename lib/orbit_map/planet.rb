# frozen_string_literal: true

module OrbitMap
  # A single planet, with an ID of the planet it orbits
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

  # Special duck-typed Planet that orbits nothing
  class CenterOfMass
    def orbit_count
      0
    end

    def orbit_tree
      []
    end
  end
end
