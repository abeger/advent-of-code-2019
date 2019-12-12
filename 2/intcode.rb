# frozen_string_literal: true

module IntCode
  # Contains instruction logic
  class Instruction
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

  # Instruction that takes 2 args and returns a result
  class BinaryInstruction < IntCode::Instruction
    def parameters
      program[(opcode_addr + 1)..(opcode_addr + 3)]
    end

    def execute
      program[result_address] = program[arg1_address].send(operator, program[arg2_address])
      program
    end

    def opcode
      1
    end

    def arg1_address
      parameters[0]
    end

    def arg2_address
      parameters[1]
    end

    def result_address
      parameters[2]
    end

    def operator
      raise 'Not implemented'
    end
  end

  # +
  class AddInstruction < IntCode::BinaryInstruction
    def operator
      :+
    end

    def opcode
      1
    end
  end

  # *
  class MultiplyInstruction < IntCode::BinaryInstruction
    def operator
      :*
    end

    def opcode
      2
    end
  end

  # End
  class HaltInstruction < IntCode::Instruction
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

  INST_MAP = {
    1 => IntCode::AddInstruction,
    2 => IntCode::MultiplyInstruction,
    99 => IntCode::HaltInstruction
  }.freeze
end

def run_program(program, options = {})
  program[1] = options.fetch(:noun, program[1])
  program[2] = options.fetch(:verb, program[2])

  pointer = 0
  while pointer < program.size
    instruction = IntCode::Instruction.create(program, pointer)
    program = instruction.execute

    next_addr = instruction.next_opcode_addr
    break if next_addr.nil?

    pointer = next_addr
  end

  program[0]
end

contents = File.read(ARGV[0])

program = contents.strip.split(',').map(&:to_i)

# Output for 2.1
# pp run_program(program, noun: 12, verb: 2)

# Output for 2.2
TARGET_OUTPUT = 19_690_720

100.times do |noun|
  output = nil
  100.times do |verb|
    output = run_program(program.clone, noun: noun, verb: verb)
    next unless output == TARGET_OUTPUT

    puts((100 * noun) + verb)
  end
  next unless output == TARGET_OUTPUT
end
