# frozen_string_literal: true

module Nanofactory
  class Factory
    CHEM_FUEL = 'FUEL'
    CHEM_ORE = 'ORE'

    def initialize(formula_text)
      @formula_text = formula_text
    end

    def formulas
      @formulas ||= FormulaParser.new(@formula_text).parse
    end

    def bank
      @bank ||= Bank.new
    end

    def fuel_formula
      formulas[CHEM_FUEL]
    end

    def requirements(chemical, qty)
      produced_qty = formulas[chemical][:qty]
      formulas[chemical][:ingredients].map do |ing|
        ing_required_qty = ing[:qty] * [(qty.to_f / produced_qty).ceil, 1].max
        next ing_required_qty if ing[:chemical] == CHEM_ORE

        requirements(ing[:chemical], ing_required_qty)
      end.sum
    end

    def required_ore
      requirements(CHEM_FUEL, 1)
    end
  end
end
