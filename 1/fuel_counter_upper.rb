# frozen_string_literal: true

def fuel(mass)
  (mass / 3).floor - 2
end

def module_fuel(mass)
  base_fuel = fuel(mass)
  return 0 if base_fuel <= 0

  base_fuel + module_fuel(base_fuel)
end

module_masses = File.readlines('input.txt')
total_fuel = module_masses.sum do |mass|
  module_fuel(mass.to_f)
end

puts "Total fuel needed:  #{total_fuel}"
