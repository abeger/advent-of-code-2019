# frozen_string_literal: true

module Nanofactory
  # Turn reactions list into a hash of formulas
  class FormulaParser
    def initialize(formula_text)
      @formula_text = formula_text
    end

    def parse
      @formula_text.each_line.map do |line|
        parse_line(line.strip)
      end.to_h
    end

    private

    def parse_line(line)
      regex = /(\d+) ([A-Z]+)/
      chemicals = line.scan(regex).map { |arr| chem_hash(arr) }
      result = chemicals.pop
      [result[:chemical], { qty: result[:qty], ingredients: chemicals }]
    end

    def chem_hash(array)
      { chemical: array[1], qty: array[0].to_i }
    end
  end
end
