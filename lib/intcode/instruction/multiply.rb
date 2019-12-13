# frozen_string_literal: true

require_relative 'binary'

module Intcode
  module Instruction
    # +
    class Multiply < Intcode::Instruction::Binary
      def operator
        :*
      end

      def opcode
        2
      end
    end
  end
end
