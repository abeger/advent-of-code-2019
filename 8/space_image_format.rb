# frozen_string_literal: true

require_relative '../lib/space_image_format'

if ARGV.count < 1
  puts 'Usage: ruby amplifier.rb <input_file>'
  exit
end

data_string = File.read(ARGV[0]).strip

photo = SpaceImageFormat::Photo.new(data_string, 25, 6)

puts 'Part 1'

min_zeros = nil
min_product = nil
photo.layers.each do |layer|
  zero_count = layer.digit_count('0')
  if min_zeros.nil? || min_zeros > zero_count
    min_zeros = zero_count
    min_product = layer.digit_count('1') * layer.digit_count('2')
  end
end

puts "Product of minimum layer is #{min_product}"
puts

puts 'Part 2'
photo.decode.each do |row|
  puts row.gsub('0', ' ').gsub('1', '#')
end
