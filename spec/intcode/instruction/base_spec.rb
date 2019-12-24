# frozen_string_literal: true

RSpec.describe Intcode::Instruction::Base do
  describe '#arg_value' do
    it 'returns the value in position mode' do
      computer = Intcode::Computer.new('001,2,3,0')
      instruction = described_class.new(computer, 0)
      allow(instruction).to receive(:num_params).and_return(1)
      expect(instruction.arg_value(0)).to eq(3)
    end

    it 'returns the value in immediate mode' do
      computer = Intcode::Computer.new('101,2,3,0')
      instruction = described_class.new(computer, 0)
      allow(instruction).to receive(:num_params).and_return(1)
      expect(instruction.arg_value(0)).to eq(2)
    end

    it 'returns the value in relative mode' do
      computer = Intcode::Computer.new('201,2,3,0')
      expect(computer).to receive(:relative_base).and_return(1)
      instruction = described_class.new(computer, 0)
      allow(instruction).to receive(:num_params).and_return(1)
      expect(instruction.arg_value(0)).to eq(0)
    end
  end

  describe '#arg_address' do
    it 'returns the address in position mode' do
      computer = Intcode::Computer.new('001,2,3,0')
      instruction = described_class.new(computer, 0)
      allow(instruction).to receive(:num_params).and_return(1)
      expect(instruction.arg_address(0)).to eq(2)
    end

    it 'acts like position mode in immediate mode' do
      computer = Intcode::Computer.new('101,2,3,0')
      instruction = described_class.new(computer, 0)
      allow(instruction).to receive(:num_params).and_return(1)
      expect(instruction.arg_address(0)).to eq(2)
    end

    it 'returns the address in relative mode' do
      computer = Intcode::Computer.new('201,2,3,0')
      expect(computer).to receive(:relative_base).and_return(1)
      instruction = described_class.new(computer, 0)
      allow(instruction).to receive(:num_params).and_return(1)
      expect(instruction.arg_address(0)).to eq(3)
    end
  end
end
