# frozen_string_literal: true

module NBodyProblem
  class Planet
    attr_reader :pos_x, :pos_y, :pos_z
    attr_reader :vel_x, :vel_y, :vel_z

    def initialize(pos_x, pos_y, pos_z)
      @pos_x = pos_x
      @pos_y = pos_y
      @pos_z = pos_z
      @vel_x = 0
      @vel_y = 0
      @vel_z = 0
    end

    def apply_velocity
      @pos_x += @vel_x
      @pos_y += @vel_y
      @pos_z += @vel_z
    end

    def apply_gravity(planet)
      @vel_x += gravity(planet.pos_x, @pos_x)
      @vel_y += gravity(planet.pos_y, @pos_y)
      @vel_z += gravity(planet.pos_z, @pos_z)
    end

    def potential_energy
      @pos_x.abs + @pos_y.abs + @pos_z.abs
    end

    def kinetic_energy
      @vel_x.abs + @vel_y.abs + @vel_z.abs
    end

    def total_energy
      potential_energy * kinetic_energy
    end

    private

    def gravity(other_val, self_val)
      return -1 if other_val < self_val

      return 1 if other_val > self_val

      0
    end
  end
end
