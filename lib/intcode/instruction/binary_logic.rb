# frozen_string_literal: true

module Intcode
  module Instruction
    # Binary instruction that takes 2 args and compares them
    class BinaryLogic < Intcode::Instruction::Binary
      def execute
        computer.write(arg_address(2), (arg_value(0).send(operator, arg_value(1)) ? 1 : 0))
      end
    end
  end
end
