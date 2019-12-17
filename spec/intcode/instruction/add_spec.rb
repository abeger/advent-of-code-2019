# frozen_string_literal: true

RSpec.describe Intcode::Instruction::Add do
  it 'adds two numbers with immediate params' do
    computer = double(Intcode::Computer)
    instruction = described_class.new(computer, ['01101', 2, 3, 0], 0)
    program = instruction.execute
    expect(program).to eq [5, 2, 3, 0]
  end

  it 'adds two numbers with indirect params' do
    computer = double(Intcode::Computer)
    instruction = described_class.new(computer, ['00001', 5, 6, 0, 99, 100, 200], 0)
    program = instruction.execute
    expect(program).to eq [300, 5, 6, 0, 99, 100, 200]
  end
end
