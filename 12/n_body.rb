# frozen_string_literal: true

require_relative '../lib/n_body'

if ARGV.count < 1
  puts "Usage: ruby #{__FILE__} <input_file>"
  exit
end

puts 'Part 1'
position_text = File.read(ARGV[0])
sim = NBodyProblem::Simulation.new(position_text)
sim.run(1000)

puts "Total energy after 1000 steps is #{sim.total_energy}"
