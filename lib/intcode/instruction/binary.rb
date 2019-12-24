# frozen_string_literal: true

require_relative 'base'

module Intcode
  module Instruction
    # Instruction that takes 2 args and returns a result
    class Binary < Intcode::Instruction::Base
      def execute
        # puts "#{arg_value(0)} #{operator} #{arg_value(1)} -> [#{result_address}]"
        program[result_address] = arg_value(0).send(operator, arg_value(1))
        program
      end

      def result_address
        parameters[2]
      end

      def num_params
        3
      end

      def operator
        raise 'Not implemented'
      end
    end
  end
end
