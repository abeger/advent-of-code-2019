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

  let(:bigger_example) do
    <<~EXAMPLE
      9 ORE => 2 A
      8 ORE => 3 B
      7 ORE => 5 C
      3 A, 4 B => 1 AB
      5 B, 7 C => 1 BC
      4 C, 1 A => 1 CA
      2 AB, 3 BC, 4 CA => 1 FUEL
    EXAMPLE
  end

  context 'examples' do
    it 'solves example 1' do
      factory = described_class.new(simple_example)
      required_ore = factory.requirements(described_class::CHEM_FUEL, 1)
      expect(required_ore).to eq(31)
    end

    it 'solves example 2' do
      factory = described_class.new(simple_example)
      required_ore = factory.requirements(described_class::CHEM_FUEL, 1)
      expect(required_ore).to eq(165)
    end
  end
end
