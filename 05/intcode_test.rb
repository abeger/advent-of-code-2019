# frozen_string_literal: true

require_relative '../lib/intcode'

if ARGV.count < 1
  puts "Usage: ruby #{__FILE__} <input_file>"
  exit
end

program_text = File.read(ARGV[0])

Intcode::Computer.new(program_text).run
