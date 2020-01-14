# frozen_string_literal: true

module Nanofactory
  # Keeps track of resources for the factory
  class Bank
    attr_reader :contents, :ore_consumed

    def initialize
      @contents = Hash.new { |hsh, key| hsh[key] = 0 }
      @ore_consumed = 0
    end

    def deposit(chemical, qty)
      raise(ArgumentError, "Can't deposit ORE") if chemical == Factory::CHEM_ORE

      @contents[chemical] += qty
    end

    def withdraw(chemical, qty)
      if chemical == Factory::CHEM_ORE
        @ore_consumed += qty
      else
        raise InsufficientFundsException if qty > @contents[chemical]

        @contents[chemical] -= qty
        @contents.delete(chemical) if @contents[chemical].zero?
      end
    end

    def balance(chemical)
      @contents[chemical]
    end
  end

  class InsufficientFundsException < StandardError; end
end
