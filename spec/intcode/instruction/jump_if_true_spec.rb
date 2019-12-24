# frozen_string_literal: true

RSpec.describe Intcode::Instruction::JumpIfTrue do
  it "doesn't jump if first evaluates to zero" do
    computer = Intcode::Computer.new('01105,0,5,4,0,99')
    instruction = described_class.new(computer, 0)
    instruction.execute
    expect(instruction.next_command_addr).to eq(3)
  end

  it 'jumps if first evaluates to nonzero' do
    computer = Intcode::Computer.new('01105,1,5,4,0,99')
    instruction = described_class.new(computer, 0)
    instruction.execute
    expect(instruction.next_command_addr).to eq(5)
  end
end
