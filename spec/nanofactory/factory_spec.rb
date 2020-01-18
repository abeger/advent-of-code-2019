# frozen_string_literal: true

RSpec.describe Nanofactory::Factory do
  let(:simple_example) do
    <<~EXAMPLE
      10 ORE => 10 A
      1 ORE => 1 B
      7 A, 1 B => 1 C
      7 A, 1 C => 1 D
      7 A, 1 D => 1 E
      7 A, 1 E => 1 FUEL
    EXAMPLE
  end

  describe '#requirements' do
    def one_fuel_test(example, ore_consumed, contents)
      multi_fuel_test(example, 1, ore_consumed, contents)
    end

    def multi_fuel_test(example, desired_output, ore_consumed, contents)
      run_test(example, 'FUEL', desired_output, ore_consumed, contents)
    end

    def run_test(example, chemical, desired_output, ore_consumed, contents)
      factory = described_class.new(example)
      bank = factory.requirements(chemical, desired_output)
      expect(bank.contents).to eq(contents)
      expect(bank.ore_consumed).to eq(ore_consumed)
    end

    it 'solves a simple one-line example' do
      example = '1 ORE => 1 FUEL'
      one_fuel_test(example, 1, 'FUEL' => 1)
    end

    it 'handles many ore required for one fuel' do
      example = '10 ORE => 1 FUEL'
      one_fuel_test(example, 10, 'FUEL' => 1)
    end

    it 'handles multiples' do
      example = '10 ORE => 1 FUEL'
      multi_fuel_test(example, 2, 20, 'FUEL' => 2)
    end

    it 'handles a simple two-line example' do
      example = "5 ORE => 1 A\n1 A => 1 FUEL"
      multi_fuel_test(example, 2, 10, 'FUEL' => 2)
    end

    it 'handles a more complicated two-line example' do
      example = "5 ORE => 2 A\n4 A => 1 FUEL"
      one_fuel_test(example, 10, 'FUEL' => 1)
    end

    it 'handles two ingredients for fuel' do
      example = <<~EXAMPLE
        5 ORE => 2 A
        2 ORE => 1 B
        4 A, 2 B => 1 FUEL
      EXAMPLE
      one_fuel_test(example, 14, 'FUEL' => 1)
    end

    it 'handles a dependent ingredient' do
      example = <<~EXAMPLE
        5 ORE => 2 A
        2 A => 1 B
        4 A, 2 B => 1 FUEL
      EXAMPLE
      one_fuel_test(example, 20, 'FUEL' => 1)
    end

    it 'handles excess' do
      example = "5 ORE => 4 A\n2 A => 1 FUEL"
      one_fuel_test(example, 5, 'FUEL' => 1, 'A' => 2)
    end

    it 'returns results' do
      example = '3 ORE => 2 A'
      run_test(example, 'A', 3, 6, 'A' => 4)
    end

    it 'distributes leftovers' do
      example = <<~EXAMPLE
        5 ORE => 3 A
        2 A => 1 B
        1 A, 2 B => 1 FUEL
      EXAMPLE
      one_fuel_test(example, 10, 'FUEL' => 1, 'A' => 1)
    end
  end
end
