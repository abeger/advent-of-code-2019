# frozen_string_literal: true

require_relative 'command'

module Intcode
  # An Intcode program
  class Computer
    attr_accessor :output_block
    attr_reader :state
    attr_reader :input_buffer
    attr_reader :relative_base

    def initialize(program_string, input_mode = :auto)
      @program_string = program_string
      @input_mode = input_mode
      reset
    end

    def program_hardcopy
      @program_hardcopy ||= @program_string.strip.split(',').map(&:to_i)
    end

    def reset
      @command_addr = 0
      @memory = Intcode::Memory.new(program_hardcopy.clone)
      @input_buffer = []
      @output_block = nil
      @state = :not_started
      @relative_base = 0
    end

    def run(noun = nil, verb = nil, &block)
      @output_block = block

      @state = :running if @state == :not_started

      write(1, noun) unless noun.nil?
      write(2, verb) unless verb.nil?

      while @command_addr < @memory.size
        instruction = Intcode::Instruction.create(self, @command_addr)
        # puts instruction.class
        instruction.execute

        break unless @state == :running

        @command_addr = instruction.next_command_addr
      end

      read(0)
    end

    def read(address)
      @memory.read(address)
    end

    def write(address, value)
      @memory.write(address, value)
    end

    def wait_for_input
      @state = :waiting_for_input
    end

    def halt
      @state = :finished
    end

    def resume
      @state = :running unless @state == :finished
    end

    def finished?
      @state == :finished
    end

    def waiting_for_input?
      @state == :waiting_for_input
    end

    # receive input
    def input
      if @input_mode == :auto
        data = load_input
        return data
      end

      print 'Enter input: '
      $stdin.gets.chomp.to_i
    end

    # output any data sent from instructions
    def output(data)
      # puts "-> #{data}"
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

    def adjust_relative_base(val)
      @relative_base += val
    end

    # Convenience method
    def memory
      @memory.contents
    end

    private

    def load_input
      @input_buffer.shift
    end
  end
end
