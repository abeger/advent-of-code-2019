# frozen_string_literal: true

module NBodyProblem
  # Simulates movement of a set of moons
  class CycleSim
    def initialize(position_text, dimension)
      @position_text = position_text
      @dimension = dimension
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

    def cycle
      original_positions = positions
      original_velocities = velocities
      current_positions = nil
      current_velocities = nil
      step_count = 0
      until original_velocities == current_velocities && original_positions == current_positions
        step
        current_positions = positions
        current_velocities = velocities
        step_count += 1
      end
      step_count
    end

    def positions
      moons.map(&:position)
    end

    def velocities
      moons.map(&:velocity)
    end

    private

    POSITION_REGEX = /<x=([-[[:digit:]]]+), y=([-[[:digit:]]]+), z=([-[[:digit:]]]+)>/.freeze

    def parse_position_text
      @position_text.each_line.map do |line|
        POSITION_REGEX.match(line) do |mdata|
          case @dimension
          when 'x'
            Dimension.new(mdata[1].to_i)
          when 'y'
            Dimension.new(mdata[2].to_i)
          when 'z'
            Dimension.new(mdata[3].to_i)
          end
        end
      end
    end

    def apply_gravity
      moons.each do |moon1|
        moons.each do |moon2|
          next if moon1 == moon2

          moon1.apply_gravity(moon2.position)
        end
      end
    end

    def apply_velocity
      moons.each(&:apply_velocity)
    end
  end
end
