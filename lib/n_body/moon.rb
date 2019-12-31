# frozen_string_literal: true

module NBodyProblem
  class Moon
    def initialize(position_hash)
      @position_hash = position_hash
    end

    def dimensions
      @dimensions ||= @position_hash.map do |dim, pos|
        [dim, Dimension.new(pos)]
      end.to_h
    end

    def positions
      dimensions.map do |key, dim|
        [key, dim.position]
      end.to_h
    end

    def apply_velocity
      dimensions.values.each(&:apply_velocity)
    end

    def apply_gravity(moon)
      other_pos = moon.positions
      dimensions.each do |key, dim|
        dim.apply_gravity(other_pos[key])
      end
    end

    def potential_energy
      dimensions.values.sum(&:potential_energy)
    end

    def kinetic_energy
      dimensions.values.sum(&:kinetic_energy)
    end

    def total_energy
      potential_energy * kinetic_energy
    end
  end
end
