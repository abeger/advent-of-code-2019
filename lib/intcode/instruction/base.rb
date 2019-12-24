# frozen_string_literal: true

module Intcode
  module Instruction
    # Parent Instruction class. Abstract.
    class Base
      attr_reader :computer
      attr_reader :command_addr

      def initialize(computer, command_addr)
        @computer = computer
        @command_addr = command_addr
      end

      def parameters
        return [] if num_params.zero?

        computer.read(command_addr + 1..command_addr + num_params)
      end

      def execute
        raise 'Not implemented'
      end

      def next_command_addr
        @command_addr + num_params + 1 # 1 for the command
      end

      def arg_value(param_index)
        return parameters[param_index] if command.immediate_param?(param_index)

        computer.read(arg_address(param_index))
      end

      def arg_address(param_index)
        # Adjust base if relative, leave at 0 if position
        base = command.relative_param?(param_index) ? computer.relative_base : 0

        parameters[param_index] + base
      end

      def command
        Command.new(computer.read(@command_addr))
      end

      # Returns the number of parameters this instruction takes
      def num_params
        raise 'Not implemented'
      end
    end
  end
end
