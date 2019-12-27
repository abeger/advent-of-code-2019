# frozen_string_literal: true

RSpec.describe MonitoringStation::Asteroid do
  describe '#direction' do
    it 'calculates direction to another asteroid' do
      a1 = described_class.new(3, 4)
      a2 = described_class.new(5, 10)
      expect(a1.direction(a2)).to eq(Math.atan2(6, 2))
    end
  end

  describe '#visible_asteroids' do
    let(:asteroid_list) do
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
    end

    it 'calculates the correct number' do
      asteroid_list.each do |a1|
        asteroid_list.each do |a2|
          a1.add_asteroid(a2)
        end
      end
      expect(asteroid_list.map(&:visible_asteroids)).to match_array([7, 7, 6, 7, 7, 7, 5, 7, 8, 7])
    end
  end
end
