# frozen_string_literal: true

require_relative 'base'

module Intcode
  module Instruction
    # Instruction that takes 2 args and returns a result
    class Binary < Intcode::Instruction::Base
      def parameters
        program[(opcode_addr + 1)..(opcode_addr + 3)]
      end

      def execute
        program[result_address] = program[arg1_address].send(operator, program[arg2_address])
        program
      end

      def opcode
        1
      end

      def arg1_address
        parameters[0]
      end

      def arg2_address
        parameters[1]
      end

      def result_address
        parameters[2]
      end

      def operator
        raise 'Not implemented'
      end
    end
  end
end


