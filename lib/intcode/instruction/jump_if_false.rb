# frozen_string_literal: true

module Intcode
  module Instruction
    # Jump to specified location if arg is 0
    class JumpIfFalse < Intcode::Instruction::Base
      def execute
        @next_command_addr = arg_value(1) if arg_value(0).zero?
      end

      def next_command_addr
        @next_command_addr ||= super
      end

      def num_params
        2
      end
    end
  end
end
