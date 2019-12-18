# frozen_string_literal: true

module Intcode
  module Instruction
    class JumpIfTrue < Intcode::Instruction::Base
      def execute
        @next_command_addr = arg_value(1) unless arg_value(0).zero?
        program
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
