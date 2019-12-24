# frozen_string_literal: true

RSpec.describe Intcode::Instruction::Input do
  it 'receives an input from the computer' do
    computer = Intcode::Computer.new('3,3,99,0', :manual)
    instruction = described_class.new(computer, 0)
    expect(computer).to receive(:input).and_return(23)
    instruction.execute
    expect(computer.memory).to eq [3, 3, 99, 23]
  end

  it 'handles relative positions' do
    computer = Intcode::Computer.new('203,3,99,0', :manual)
    computer.adjust_relative_base(4)
    instruction = described_class.new(computer, 0)
    expect(computer).to receive(:input).and_return(23)
    instruction.execute
    expect(computer.memory).to match_array([203, 3, 99, 0, 0, 0, 0, 23])
  end
end
