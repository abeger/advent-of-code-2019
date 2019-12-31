# frozen_string_literal: true

RSpec.describe NBodyProblem::Simulation do
  let(:position_text) do
    <<~MOONS
      <x=-1, y=0, z=2>
      <x=2, y=-10, z=-7>
      <x=4, y=-8, z=8>
      <x=3, y=5, z=-1>
    MOONS
  end

  def expect_moon(moon, x, y, z)
    expect(moon.pos_x).to eq(x)
    expect(moon.pos_y).to eq(y)
    expect(moon.pos_z).to eq(z)
  end

  describe '#moons' do
    it 'positions moons correctly' do
      sim = described_class.new(position_text)
      moons = sim.moons

      expect_moon(moons[0], -1, 0, 2)
      expect_moon(moons[1], 2, -10, -7)
      expect_moon(moons[2], 4, -8, 8)
      expect_moon(moons[3], 3, 5, -1)
    end
  end

  describe '#step' do
    it 'moves the moons correctly' do
      sim = described_class.new(position_text)
      sim.step

      moons = sim.moons

      expect_moon(moons[0], 2, -1, 1)
      expect_moon(moons[1], 3, -7, -4)
      expect_moon(moons[2], 1, -7, 5)
      expect_moon(moons[3], 2, 2, 0)
    end
  end
end
