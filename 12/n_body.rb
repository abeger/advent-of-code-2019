# frozen_string_literal: true

require_relative '../lib/n_body'

if ARGV.count < 1
  puts "Usage: ruby #{__FILE__} <input_file>"
  exit
end

puts 'Part 1'
position_text = File.read(ARGV[0])
#sim = NBodyProblem::Simulation.new(position_text)
#sim.run(1000)

#puts "Total energy after 1000 steps is #{sim.total_energy}"

puts 'Part 2'

csim_x = NBodyProblem::CycleSim.new(position_text, 'x')
x_steps = csim_x.cycle

csim_y = NBodyProblem::CycleSim.new(position_text, 'y')
y_steps = csim_y.cycle

csim_z = NBodyProblem::CycleSim.new(position_text, 'z')
z_steps = csim_z.cycle

total_steps = x_steps.lcm(y_steps).lcm(z_steps)

puts "#{total_steps} until the moons have cycled back"
