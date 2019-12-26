# frozen_string_literal: true

require_relative '../lib/intcode'

if ARGV.count < 1
  puts 'Usage: ruby amplifier.rb <input_file>'
  exit
end

program_text = File.read(ARGV[0])

puts 'Part 1'

computer = Intcode::Computer.new(program_text)
computer.add_input(1)
computer.run
