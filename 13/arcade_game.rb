# frozen_string_literal: true

require_relative '../lib/arcade_game'

if ARGV.count < 1
  puts "Usage: ruby #{__FILE__} <input_file>"
  exit
end

program_text = File.read(ARGV[0])
game = ArcadeGame::Game.new(program_text, true, true)
game.run
puts 'GAME OVER'
puts "Score: #{game.score}"
