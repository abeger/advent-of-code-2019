# frozen_string_literal: true

module NBodyProblem
  class Dimension
    attr_reader :position, :velocity

    def initialize(pos)
      @position = pos
      @velocity = 0
    end

    def apply_velocity
      @position += velocity
    end

    def apply_gravity(other_position)
      @velocity += gravity(other_position, position)
    end

    def potential_energy
      position.abs
    end

    def kinetic_energy
      velocity.abs
    end

    private

    def gravity(other_val, self_val)
      return -1 if other_val < self_val

      return 1 if other_val > self_val

      0
    end
  end
end
