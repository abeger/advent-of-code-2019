# frozen_string_literal: true

module Intcode
  # An Intcode program
  class Program
    def initialize(program)
      @program_hardcopy = program
    end

    def run(noun, verb)
      program = @program_hardcopy.clone

      program[1] = noun.nil? ? program[1] : noun
      program[2] = verb.nil? ? program[2] : verb

      pointer = 0
      while pointer < program.size
        instruction = Intcode::Instruction::Base.create(program, pointer)
        program = instruction.execute

        next_addr = instruction.next_opcode_addr
        break if next_addr.nil?

        pointer = next_addr
      end

      program[0]
    end
  end
end
