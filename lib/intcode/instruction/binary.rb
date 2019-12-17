# frozen_string_literal: true

require_relative 'base'

module Intcode
  module Instruction
    # Instruction that takes 2 args and returns a result
    class Binary < Intcode::Instruction::Base
      def parameters
        program[(command_addr + 1)..(command_addr + 3)]
      end

      def execute
        program[result_address] = arg1_value.send(operator, arg2_value)
        program
      end

      def arg1_value
        return parameters[0] if command.immediate_param?(1)

        program[parameters[0]]
      end

      def arg2_value
        return parameters[1] if command.immediate_param?(2)

        program[parameters[1]]
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


