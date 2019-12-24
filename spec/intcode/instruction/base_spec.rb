# frozen_string_literal: true

RSpec.describe Intcode::Instruction::Base do
  describe '#arg_value' do
    let(:computer) { double(Intcode::Computer) }

    it 'returns the value in immediate mode' do
      instruction = described_class.new(computer, ['101', 2, 3, 0], 0)
      allow(instruction).to receive(:num_params).and_return(1)
      expect(instruction.arg_value(0)).to eq(2)
    end

    it 'returns the value in relative mode' do
      instruction = described_class.new(computer, ['201', 2, 3, 0], 0)
      expect(computer).to receive(:relative_base).and_return(1)
      allow(instruction).to receive(:num_params).and_return(1)
      expect(instruction.arg_value(0)).to eq(0)
    end

    it 'returns the value in position mode' do
      instruction = described_class.new(computer, ['001', 2, 3, 0], 0)
      allow(instruction).to receive(:num_params).and_return(1)
      expect(instruction.arg_value(0)).to eq(3)
    end
  end
end
