# frozen_string_literal: true

RSpec.describe Intcode::Instruction::Equals do
  it 'writes 1 if params are equal' do
    computer = Intcode::Computer.new('01108,2,2,0')
    instruction = described_class.new(computer, 0)
    instruction.execute
    expect(computer.memory).to eq [1, 2, 2, 0]
  end

  it 'writes 0 if params are not equal' do
    computer = Intcode::Computer.new('01108,2,3,0')
    instruction = described_class.new(computer, 0)
    instruction.execute
    expect(computer.memory).to eq [0, 2, 3, 0]
  end
end
