# frozen_string_literal: true

RSpec.describe ArcadeGame::Game do
  context 'puzzles' do
    let(:program_text) { File.read('13/input.txt') }

    it 'solves part 1' do
      game = described_class.new(program_text)
      game.run
      expect(game.screen.num_tiles(ArcadeGame::Screen::TILE_BLOCK)).to eq(236)
    end
  end
end
