# frozen_string_literal: true

require_relative '../lib/nanofactory'

if ARGV.count < 1
  puts "Usage: ruby #{__FILE__} <input_file>"
  exit
end

reactions_list = File.read(ARGV[0])

req_fuel = 2_267_486
ore_supply = 1_000_000_000_000

factory = Nanofactory::Factory.new(reactions_list)
bank = factory.requirements('FUEL', req_fuel)
pp bank.ore_consumed
pp bank.ore_consumed < ore_supply
