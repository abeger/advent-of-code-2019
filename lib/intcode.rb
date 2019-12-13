# frozen_string_literal: true

require 'require_all'

require_rel 'intcode'

module Intcode
  INST_MAP = {
    1 => Intcode::Instruction::Add,
    2 => Intcode::Instruction::Multiply,
    99 => Intcode::Instruction::Halt
  }.freeze
end
