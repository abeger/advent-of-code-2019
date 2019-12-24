# frozen_string_literal: true

module Intcode
  module Instruction
    # arg0 == arg1
    class Equals < Intcode::Instruction::BinaryLogic
      def operator
        :==
      end
    end
  end
end
