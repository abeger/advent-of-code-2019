# frozen_string_literal: true

RSpec.describe Intcode::Instruction::Output do
  it 'outputs an immediate value to the computer' do
    program = ['00104', 23, 99]
    computer = double(Intcode::Computer)
    instruction = described_class.new(computer, program, 0)
    expect(computer).to receive(:output).with(23)
    instruction.execute
  end
end
