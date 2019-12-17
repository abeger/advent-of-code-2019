# frozen_string_literal: true

require_relative '../lib/intcode'

if ARGV.count < 1
  puts 'Usage: ruby intcode.rb <input_file>'
  exit
end

program_text = File.read(ARGV[0])

puts 'Part 1'

# Output for 2.1
pp Intcode::Computer.new(program_text).run(12, 2)

puts 'Part 2'

# Output for 2.2
TARGET_OUTPUT = 19_690_720

program = Intcode::Computer.new(program_text)

100.times do |noun|
  output = nil
  100.times do |verb|
    output = program.run(noun, verb)
    next unless output == TARGET_OUTPUT

    puts((100 * noun) + verb)
  end
  next unless output == TARGET_OUTPUT
end
puts 'All done'
