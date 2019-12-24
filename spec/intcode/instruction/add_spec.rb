# frozen_string_literal: true

RSpec.describe Intcode::Instruction::Add do
  it 'adds two numbers with immediate params' do
    computer = Intcode::Computer.new('01101,2,3,0')
    instruction = described_class.new(computer, 0)
    instruction.execute
    expect(computer.memory).to eq [5, 2, 3, 0]
  end

  it 'adds two numbers with indirect params' do
    computer = Intcode::Computer.new('00001,5,6,0,99,100,200')
    instruction = described_class.new(computer, 0)
    instruction.execute
    expect(computer.memory).to eq [300, 5, 6, 0, 99, 100, 200]
  end
end
