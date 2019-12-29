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

  let(:small_map) do
    <<~SMALL_MAP
      .#....#####...#..
      ##...##.#####..##
      ##...#...#.#####.
      ..#.....X...###..
      ..#.#.....#....##
    SMALL_MAP
  end

  context 'examples' do
    it 'solves example 1' do
      map = described_class.new(tiny_map)
      expect(map.best_station_location).to eq(MonitoringStation::Asteroid.new(3, 4))
    end

    it 'destroys in the correct order for part 2 example 1' do
      map = described_class.new(small_map)
      asteroid = MonitoringStation::Asteroid.new(8, 3)
      destruction_order = asteroid.destruction_order(map.asteroids)
      expect(destruction_order[0]).to eq(MonitoringStation::Asteroid.new(8, 1))
      expect(destruction_order[17]).to eq(MonitoringStation::Asteroid.new(4, 4))
      expect(destruction_order.last).to eq(MonitoringStation::Asteroid.new(14, 3))
    end
  end

  context 'puzzles' do
    let(:map_text) { File.read('10/input.txt') }

    it 'solves part 1' do
      map = described_class.new(map_text)
      loc = map.best_station_location
      expected = MonitoringStation::Asteroid.new(19, 11)
      expect(loc).to eq(expected)
    end

    it 'solves part 2' do
      map = described_class.new(map_text)
      loc = map.best_station_location
      destruction_order = loc.destruction_order(map.asteroids)
      expect(destruction_order[199]).to eq(MonitoringStation::Asteroid.new(12, 5))
    end
  end
end
