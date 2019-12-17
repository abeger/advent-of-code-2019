# frozen_string_literal: true

require_relative 'command'

module Intcode
  # An Intcode program
  class Computer
    def initialize(program_string)
      @program_string = program_string
    end

    def program_hardcopy
      @program_hardcopy ||= @program_string.strip.split(',').map(&:to_i)
    end

    def run(noun = nil, verb = nil)
      program = program_hardcopy.clone

      program[1] = noun unless noun.nil?
      program[2] = verb unless verb.nil?

      command_addr = 0
      while command_addr < program.size
        instruction = Intcode::Instruction::Base.create(self, program, command_addr)
        program = instruction.execute

        next_addr = instruction.next_command_addr
        break if next_addr.nil?

        command_addr = next_addr
      end

      program[0]
    end

    # receive input
    def input
      gets
    end

    # output any data sent from instructions
    def output(data)
      puts data
    end
  end
end
