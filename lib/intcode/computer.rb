# frozen_string_literal: true

require_relative 'command'

module Intcode
  # An Intcode program
  class Computer
    def initialize(program_string)
      @program_string = program_string
      reset
    end

    def program_hardcopy
      @program_hardcopy ||= @program_string.strip.split(',').map(&:to_i)
    end

    def reset
      @command_addr = 0
      @program = program_hardcopy.clone
      @input_buffer = []
      @output_block = nil
    end

    def run(noun = nil, verb = nil, &block)
      @output_block = block

      @program[1] = noun unless noun.nil?
      @program[2] = verb unless verb.nil?

      while @command_addr < @program.size
        instruction = Intcode::Instruction.create(self, @program, @command_addr)
        @program = instruction.execute

        next_addr = instruction.next_command_addr
        break if next_addr.nil?

        @command_addr = next_addr
      end

      @program[0]
    end

    # receive input
    def input
      data = load_input
      return data unless data.nil?

      print 'Enter input: '
      $stdin.gets.chomp.to_i
    end

    # output any data sent from instructions
    def output(data)
      if output_block
        output_block.call(data)
      else
        puts data
      end
    end

    def add_input(data)
      @input_buffer << data
    end

    def input?
      !@input_buffer.empty?
    end

    attr_accessor :output_block

    private

    def load_input
      @input_buffer.shift
    end
  end
end
