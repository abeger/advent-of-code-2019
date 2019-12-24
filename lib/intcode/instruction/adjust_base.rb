# frozen_string_literal: true

require_relative 'base'

module Intcode
  module Instruction
    # Adjust the computer's relative base by a value
    class AdjustBase < Intcode::Instruction::Base
      def execute
        computer.adjust_relative_base(arg_value(0))
        program
      end

      def num_params
        1
      end
    end
  end
end
