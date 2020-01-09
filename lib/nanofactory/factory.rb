# frozen_string_literal: true

module Nanofactory
  class Factory
    CHEM_FUEL = 'FUEL'
    CHEM_ORE = 'ORE'

    def initialize(formula_text)
      @formula_text = formula_text
    end

    def formulas
      @formulas ||= parse_formulas
    end

    def fuel_formula
      formulas[CHEM_FUEL]
    end

    def requirements(chemical, qty)
      # puts "#{qty} #{chemical}"
      produced_qty = formulas[chemical][:qty]
      # pp formulas[chemical]
      formulas[chemical][:ingredients].map do |ing|
        ing_required_qty = ing[:qty] * [qty / produced_qty, 1].max
        if ing[:chemical] == CHEM_ORE
          next ing_required_qty
        end
        requirements(ing[:chemical], ing_required_qty)
      end.sum
    end

    def required_ore(qty = 1)
      return requirements(CHEM_FUEL, qty)
    end

    private

    def parse_formulas
      @formula_text.each_line.map do |line|
        parse_line(line.strip)
      end.to_h
    end

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
