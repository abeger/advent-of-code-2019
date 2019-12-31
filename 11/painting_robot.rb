# frozen_string_literal: true

require_relative '../lib/painting_robot'

if ARGV.count < 1
  puts "Usage: ruby #{__FILE__} <input_file>"
  exit
end

puts 'Part 1'
program_text = File.read(ARGV[0])
robot = PaintingRobot::Robot.new(program_text)
robot.run

puts "#{robot.hull.panels_painted} panels painted"

puts 'Part 2'
robot = PaintingRobot::Robot.new(program_text)
robot.paint(PaintingRobot::Panel::COLOR_WHITE)
robot.run
puts robot.hull.display
