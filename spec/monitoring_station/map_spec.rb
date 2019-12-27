# frozen_string_literal: true

RSpec.describe MonitoringStation::Map do
  describe '#asteroids' do
    let(:tiny_map) do
      <<~TINY_MAP
        .#..#
        .....
        #####
        ....#
        ...##
      TINY_MAP
    end

    it 'correctly parses map text' do
      map = described_class.new(tiny_map)
      expect(map.asteroids).to match_array(
        [
          MonitoringStation::Asteroid.new(1, 0),
          MonitoringStation::Asteroid.new(4, 0),
          MonitoringStation::Asteroid.new(0, 2),
          MonitoringStation::Asteroid.new(1, 2),
          MonitoringStation::Asteroid.new(2, 2),
          MonitoringStation::Asteroid.new(3, 2),
          MonitoringStation::Asteroid.new(4, 2),
          MonitoringStation::Asteroid.new(4, 3),
          MonitoringStation::Asteroid.new(3, 4),
          MonitoringStation::Asteroid.new(4, 4)
        ]
      )
    end
  end
end
