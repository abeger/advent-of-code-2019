# frozen_string_literal: true

require_relative 'base'

module Intcode
  module Instruction
    # Print out some output
    class Output < Intcode::Instruction::Base
      def parameters
        program[command_addr + 1..command_addr + 1]
      end

      def execute
        computer.output(arg1_value)
        program
      end

      def arg1_value
        return parameters[0] if command.immediate_param?(1)

        program[parameters[0]]
      end

      def opcode
        4
      end
    end
  end
end
