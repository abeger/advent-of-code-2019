# frozen_string_literal: true

require_relative '../lib/intcode'

contents = File.read(ARGV[0])

program_text = contents.strip.split(',').map(&:to_i)

# Output for 2.1
pp Intcode::Program.new(program_text).run(12, 2)

# Output for 2.2
TARGET_OUTPUT = 19_690_720

program = Intcode::Program.new(program_text)

100.times do |noun|
  output = nil
  100.times do |verb|
    output = program.run(noun, verb)
    next unless output == TARGET_OUTPUT

    puts((100 * noun) + verb)
  end
  next unless output == TARGET_OUTPUT
end
