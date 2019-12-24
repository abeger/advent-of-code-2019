# frozen_string_literal: true

module Intcode
  module Instruction
    # arg0 < arg1
    class LessThan < Intcode::Instruction::BinaryLogic
      def operator
        :<
      end
    end
  end
end
