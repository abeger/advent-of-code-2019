# frozen_string_literal: true

require_relative 'base'

module Intcode
  module Instruction
    # Print out some output
    class Output < Intcode::Instruction::Base
      def execute
        computer.output(arg_value(0))
      end

      def num_params
        1
      end
    end
  end
end
