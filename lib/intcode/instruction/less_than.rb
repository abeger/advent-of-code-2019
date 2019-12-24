# frozen_string_literal: true

module Intcode
  module Instruction
    # arg0 < arg1
    class LessThan < Intcode::Instruction::Binary
      def operator
        :<
      end

      def execute
        computer.write(result_address, (arg_value(0).send(operator, arg_value(1)) ? 1 : 0))
      end
    end
  end
end
