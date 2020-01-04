# frozen_string_literal: true

RSpec.describe NBodyProblem::Simulation do
  context 'examples' do
    let(:very_long_example) do
      <<~EXAMPLE
        <x=-8, y=-10, z=0>
        <x=5, y=5, z=10>
        <x=2, y=-7, z=3>
        <x=9, y=-8, z=-3>
      EXAMPLE
    end

    let(:short_example) do
      <<~EXAMPLE
        <x=-1, y=0, z=2>
        <x=2, y=-10, z=-7>
        <x=4, y=-8, z=8>
        <x=3, y=5, z=-1>
      EXAMPLE
    end

    it 'solves part 2 for the short example' do
      sim = described_class.new(short_example)
      expect(sim.cycle_steps).to eq(2772)
    end

    it 'solves part 2 for the very long example' do
      sim = described_class.new(very_long_example)
      expect(sim.cycle_steps).to eq(4_686_774_924)
    end
  end

  context 'puzzles' do
    let(:position_text) { File.read('12/input.txt') }

    it 'solves part 1' do
      sim = described_class.new(position_text)
      sim.run(1000)
      expect(sim.total_energy).to eq(12_490)
    end

    it 'solves part 2', :slow do
      sim = described_class.new(position_text)
      expect(sim.cycle_steps).to eq(392_733_896_255_168)
    end
  end
end
