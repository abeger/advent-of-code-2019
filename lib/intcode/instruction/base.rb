# frozen_string_literal: true

module Intcode
  module Instruction
    # Parent Instruction class. Abstract.
    class Base
      attr_reader :computer
      attr_reader :program
      attr_reader :command_addr

      def initialize(computer, program, command_addr)
        @computer = computer
        @program = program
        @command_addr = command_addr
      end

      def parameters
        return [] if num_params.zero?

        program[command_addr + 1..command_addr + num_params]
      end

      def execute
        raise 'Not implemented'
      end

      def next_command_addr
        @command_addr + num_params + 1 # 1 for the command
      end

      def arg_value(param_index)
        return parameters[param_index] if command.immediate_param?(param_index)

        program[parameters[param_index]]
      end

      def opcode
        raise 'Not implemented'
      end

      def command
        Command.new(program[@command_addr])
      end

      # Returns the number of parameters this instruction takes
      def num_params
        raise 'Not implemented'
      end

      def self.create(computer, program, command_addr)
        command = Command.new(program[command_addr])
        clazz = INST_MAP[command.opcode]
        clazz.new(computer, program, command_addr)
      end
    end
  end
end
