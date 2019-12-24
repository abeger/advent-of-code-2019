# frozen_string_literal: true

require 'require_all'

require_rel 'instruction'

module Intcode
  # Module containing all instructions
  module Instruction
    # Map of opcodes to instructions.
    # This is the only place explicit opcode numbers show up.
    INSTRUCTION_MAP = {
      1 => Intcode::Instruction::Add,
      2 => Intcode::Instruction::Multiply,
      3 => Intcode::Instruction::Input,
      4 => Intcode::Instruction::Output,
      5 => Intcode::Instruction::JumpIfTrue,
      6 => Intcode::Instruction::JumpIfFalse,
      7 => Intcode::Instruction::LessThan,
      8 => Intcode::Instruction::Equals,
      9 => Intcode::Instruction::AdjustBase,
      99 => Intcode::Instruction::Halt
    }.freeze

    def self.create(computer, program, command_addr)
      command = Command.new(program[command_addr])
      clazz = INSTRUCTION_MAP[command.opcode]
      clazz.new(computer, program, command_addr)
    end
  end
end
