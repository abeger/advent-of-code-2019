# frozen_string_literal: true

module Intcode
  # Represents the memory of the computer
  class Memory
    attr_reader :contents

    def initialize(contents, default = 0)
      @contents = contents
      @default = default
    end

    def read(address)
      expand(address) if address >= contents.size
      contents[address]
    end

    def write(address, value)
      expand(address) if address >= contents.size
      contents[address] = value
    end

    private

    def expand(address)
      extra_memory = Array.new(address - contents.size + 1, @default)
      @contents += extra_memory
    end
  end
end
