# frozen_string_literal: true

RSpec.describe Intcode::Instruction::JumpIfTrue do
  it "doesn't jump if first evaluates to zero" do
    program = ['01105', 0, 5, 4, 0, 99]
    computer = double(Intcode::Computer)
    instruction = described_class.new(computer, program, 0)
    new_program = instruction.execute
    expect(new_program).to eq(program)
    expect(instruction.next_command_addr).to eq(3)
  end

  it 'jumps if first evaluates to nonzero' do
    program = ['01105', 1, 5, 4, 0, 99]
    computer = double(Intcode::Computer)
    instruction = described_class.new(computer, program, 0)
    new_program = instruction.execute
    expect(new_program).to eq(program)
    expect(instruction.next_command_addr).to eq(5)
  end
end
