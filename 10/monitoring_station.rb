# frozen_string_literal: true

require_relative '../lib/monitoring_station'

if ARGV.count < 1
  puts "Usage: ruby #{__FILE__} <input_file>"
  exit
end

map_text = File.read(ARGV[0])
map = MonitoringStation::Map.new(map_text)
puts "Best location is #{map.best_station_location} with #{map.best_station_location.visible(map.asteroids)} visible asteroids"
destruction_order = map.best_station_location.destruction_order(map.asteroids)
puts "200th asteroid destroyed is #{destruction_order[199]}"
