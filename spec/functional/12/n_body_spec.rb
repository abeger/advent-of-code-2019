# frozen_string_literal: true

RSpec.describe NBodyProblem::Simulation do
  context 'puzzles' do
    let(:position_text) { File.read('12/input.txt') }

    it 'solves part 1' do
      sim = NBodyProblem::Simulation.new(position_text)
      sim.run(1000)
      expect(sim.total_energy).to eq(12_490)
    end
  end
end
