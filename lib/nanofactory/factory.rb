# frozen_string_literal: true

module Nanofactory
  # Turns ore into fuel
  class Factory
    CHEM_FUEL = 'FUEL'
    CHEM_ORE = 'ORE'

    def initialize(formula_text)
      @formula_text = formula_text
    end

    def formulas
      @formulas ||= FormulaParser.new(@formula_text).parse
    end

    def fuel_formula
      formulas[CHEM_FUEL]
    end

    def requirements(chemical, requested_qty, bank = Bank.new)
      formula = formulas[chemical]
      produced_qty = formula[:qty]
      ingredients = formula[:ingredients]

      multiplier = (requested_qty.to_f / produced_qty).ceil
      loop do
        enough = true
        ingredients.each do |chem_hash|
          chem = chem_hash[:chemical]
          req_qty = chem_hash[:qty] * multiplier
          next if bank.enough?(chem, req_qty)

          enough = false
          bank = requirements(chem, req_qty - bank.balance(chem), bank)
        end
        break if enough
      end

      bank = perform_withdrawals(ingredients, multiplier, bank)
      bank.deposit(chemical, multiplier * produced_qty)

      bank
    end

    def perform_withdrawals(ingredients, multiplier, bank)
      ingredients.each do |chem_hash|
        req_qty = multiplier * chem_hash[:qty]
        bank.withdraw(chem_hash[:chemical], req_qty)
      end

      bank
    end

    def required_ore
      requirements(CHEM_FUEL, 1).ore_consumed
    end
  end
end
