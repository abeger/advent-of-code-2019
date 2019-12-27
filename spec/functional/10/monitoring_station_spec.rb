# frozen_string_literal: true

RSpec.describe MonitoringStation::Map do
  let(:tiny_map) do
    <<~TINY_MAP
      .#..#
      .....
      #####
      ....#
      ...##
    TINY_MAP
  end

  context 'examples' do
    it 'solves example 1' do
      map = described_class.new(tiny_map)
      expect(map.best_station_location).to eq(MonitoringStation::Asteroid.new(3, 4))
    end
  end

  context 'puzzles' do
    let(:map_text) { File.read('10/input.txt') }

    it 'solves part 1' do
      map = described_class.new(map_text)
      loc = map.best_station_location
      pp loc.class
      expected = MonitoringStation::Asteroid.new(19, 11)
      # expected = MonitoringStation::Asteroid.new(19, 10)
      expect(loc).to eq(expected)
    end
  end
end
