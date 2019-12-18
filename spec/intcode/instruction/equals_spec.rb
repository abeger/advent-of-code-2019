# frozen_string_literal: true

RSpec.describe Intcode::Instruction::Equals do
  it 'writes 1 if params are equal' do
    computer = double(Intcode::Computer)
    instruction = described_class.new(computer, ['01108', 2, 2, 0], 0)
    program = instruction.execute
    expect(program).to eq [1, 2, 2, 0]
  end

  it 'writes 0 if params are not equal' do
    computer = double(Intcode::Computer)
    instruction = described_class.new(computer, ['01108', 2, 3, 0], 0)
    program = instruction.execute
    expect(program).to eq [0, 2, 3, 0]
  end
end
