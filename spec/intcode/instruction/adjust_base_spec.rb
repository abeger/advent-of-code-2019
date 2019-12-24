# frozen_string_literal: true

RSpec.describe Intcode::Instruction::AdjustBase do
  it 'tells the computer to adjust its relative base' do
    computer = double(Intcode::Computer)
    instruction = described_class.new(computer, ['109', 2, 3, 0], 0)
    expect(computer).to receive(:adjust_relative_base).with(2)
    instruction.execute
  end
end
