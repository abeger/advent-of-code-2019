# frozen_string_literal: true

RSpec.describe OrbitMap::Map do
  context 'puzzles' do
    let(:map_array) { File.readlines('6/input.txt') }

    it 'solves part 1' do
      map = described_class.new(map_array)
      expect(map.checksum).to eq(312_697)
    end

    it 'solves part 2' do
      map = described_class.new(map_array)
      expect(map.find('YOU').orbit_hop('SAN')).to eq(466)
    end
  end
end
