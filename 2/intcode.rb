# frozen_string_literal: true

def run_program(program, options = {})
  index = 0

  program[1] = options.fetch(:noun, program[1])
  program[2] = options.fetch(:verb, program[2])

  while index < program.size
    opcode = program[index]
    address1 = program[index + 1]
    address2 = program[index + 2]
    target = program[index + 3]

    case opcode
    when 1
      program[target] = program[address1] + program[address2]
    when 2
      program[target] = program[address1] * program[address2]
    when 99
      break
    end

    index += 4
  end

  program[0]
end

contents = File.read(ARGV[0])

program = contents.strip.split(',').map(&:to_i)

# Restore state

pp run_program(program, noun: 12, verb: 2)
