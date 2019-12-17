# frozen_string_literal: true

require_relative 'base'

module Intcode
  module Instruction
    # Take user input
    class Input < Intcode::Instruction::Base
      def parameters
        program[command_addr + 1..command_addr + 1]
      end

      def execute
        program[result_address] = computer.input
        program
      end

      def result_address
        parameters[0]
      end

      def opcode
        3
      end
    end
  end
end
