# frozen_string_literal: true

require_relative 'binary'

module Intcode
  module Instruction
    # +
    class Add < Intcode::Instruction::Binary
      def operator
        :+
      end
    end
  end
end
