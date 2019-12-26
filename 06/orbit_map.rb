# frozen_string_literal: true

require_relative '../lib/orbit_map'

if ARGV.count < 1
  puts 'Usage: ruby orbit_count.rb <input_file>'
  exit
end

map_array = File.readlines(ARGV[0])

map = OrbitMap::Map.new(map_array)
puts 'Checksum: ' + map.checksum.to_s

puts 'Hops: ' + map.find('YOU').orbit_hop('SAN').to_s
