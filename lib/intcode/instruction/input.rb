# frozen_string_literal: true

require_relative 'base'

module Intcode
  module Instruction
    # Take user input
    class Input < Intcode::Instruction::Base
      def execute
        input = computer.input
        if input.nil?
          # Can't get input, do nothing and tell the computer to wait
          computer.wait_for_input
        else
          # puts "input #{input} -> [#{result_address}]"
          computer.write(result_address, input)
          computer.resume
        end
      end

      def result_address
        parameters[0]
      end

      def num_params
        1
      end
    end
  end
end
