# frozen_string_literal: true

RSpec.describe Intcode::Instruction::Output do
  it 'outputs an immediate value to the computer' do
    computer = Intcode::Computer.new('00104,23,99')
    instruction = described_class.new(computer, 0)
    expect(computer).to receive(:output).with(23)
    instruction.execute
  end
end
