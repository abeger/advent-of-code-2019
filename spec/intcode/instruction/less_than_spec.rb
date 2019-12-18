# frozen_string_literal: true

RSpec.describe Intcode::Instruction::LessThan do
  it 'writes 1 if param 1 is less than param 2' do
    computer = double(Intcode::Computer)
    instruction = described_class.new(computer, ['01108', 2, 3, 0], 0)
    program = instruction.execute
    expect(program).to eq [1, 2, 3, 0]
  end

  it 'writes 0 if param 1 is greater than param 2' do
    computer = double(Intcode::Computer)
    instruction = described_class.new(computer, ['01108', 2, 1, 0], 0)
    program = instruction.execute
    expect(program).to eq [0, 2, 1, 0]
  end

  it 'writes 0 if param 1 is equal to param 2' do
    computer = double(Intcode::Computer)
    instruction = described_class.new(computer, ['01108', 2, 2, 0], 0)
    program = instruction.execute
    expect(program).to eq [0, 2, 2, 0]
  end
end
