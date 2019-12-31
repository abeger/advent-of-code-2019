# frozen_string_literal: true

module NBodyProblem
  # Simulates movement of a set of planets
  class Simulation
    def initialize(position_text)
      @position_text = position_text
    end

    def moons
      @moons ||= parse_position_text
    end

    def run(num_steps)
      num_steps.times do
        step
      end
    end

    def step
      apply_gravity
      apply_velocity
    end

    def total_energy
      moons.sum(&:total_energy)
    end

    private

    POSITION_REGEX = /<x=([-[[:digit:]]]+), y=([-[[:digit:]]]+), z=([-[[:digit:]]]+)>/.freeze

    def parse_position_text
      @position_text.each_line.map do |line|
        POSITION_REGEX.match(line) do |mdata|
          x = mdata[1].to_i
          y = mdata[2].to_i
          z = mdata[3].to_i
          NBodyProblem::Planet.new(x, y, z)
        end
      end
    end

    def apply_gravity
      moons.each do |moon1|
        moons.each do |moon2|
          next if moon1 == moon2

          moon1.apply_gravity(moon2)
        end
      end
    end

    def apply_velocity
      moons.each(&:apply_velocity)
    end
  end
end
