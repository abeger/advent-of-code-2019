# frozen_string_literal: true

module Intcode
  # Descriptor is 3 param switches [0-1].
  # Param switches are laid out "321".
  # Params followed by 2-digit opcode.
  class Command
    def initialize(code)
      @code = code.to_s # Make sure we're dealing with a string
    end

    # pad the code out to 5 digits
    def code
      @code.rjust(5, '0')
    end

    def opcode
      code[3..4].to_i
    end

    def immediate_param?(param_no)
      index = 2 - param_no
      code[index] == '1'
    end
  end
end
