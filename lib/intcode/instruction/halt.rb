# frozen_string_literal: true

require_relative 'base'

module Intcode
  module Instruction
    # End
    class Halt < Intcode::Instruction::Base
      def parameters
        []
      end

      def execute
        program
      end

      def opcode
        99
      end

      def next_opcode_addr
        nil
      end
    end
  end
end
