# frozen_string_literal: true

RSpec.describe Intcode::Instruction::Input do
  it 'receives an input from the computer' do
    program = ['3', 3, 99, 0]
    computer = double(Intcode::Computer)
    instruction = described_class.new(computer, program, 0)
    expect(computer).to receive(:input).and_return(23)
    new_program = instruction.execute
    expect(new_program).to eq ['3', 3, 99, 23]
  end
end
