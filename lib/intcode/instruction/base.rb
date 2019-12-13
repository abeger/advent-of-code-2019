# frozen_string_literal: true

module Intcode
  module Instruction
    # Parent Instruction class. Abstract.
    class Base
      attr_accessor :opcode_addr
      attr_accessor :program

      def initialize(program, opcode_addr)
        @program = program
        @opcode_addr = opcode_addr
      end

      def parameters
        raise 'Not implemented'
      end

      def execute
        raise 'Not implemented'
      end

      def next_opcode_addr
        @opcode_addr + parameters.count + 1 # 1 for the opcode
      end

      def opcode
        raise 'Not implemented'
      end

      def self.create(program, opcode_addr)
        clazz = INST_MAP[program[opcode_addr]]
        clazz.new(program, opcode_addr)
      end
    end
  end
end

