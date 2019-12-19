# frozen_string_literal: true

require_relative '../lib/intcode'

if ARGV.count < 1
  puts 'Usage: ruby intcode_test.rb <input_file>'
  exit
end

program_text = File.read(ARGV[0])

Intcode::Computer.new(program_text).run
