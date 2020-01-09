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

  describe '#formulas' do
    it 'parses formula text correctly' do
      factory = described_class.new(simple_example)

      expected_hash = {
        'A' => { qty: 10, ingredients: [{ chemical: 'ORE', qty: 10 }] },
        'B' => { qty: 1, ingredients: [{ chemical: 'ORE', qty: 1 }] },
        'C' => { qty: 1, ingredients: [{ chemical: 'A', qty: 7 }, { chemical: 'B', qty: 1 }] },
        'D' => { qty: 1, ingredients: [{ chemical: 'A', qty: 7 }, { chemical: 'C', qty: 1 }] },
        'E' => { qty: 1, ingredients: [{ chemical: 'A', qty: 7 }, { chemical: 'D', qty: 1 }] },
        'FUEL' => { qty: 1, ingredients: [{ chemical: 'A', qty: 7 }, { chemical: 'E', qty: 1 }] }
      }
      expect(factory.formulas).to eq(expected_hash)
    end
  end

  describe '#required_ore' do
    it 'solves a simple one-line example' do
      example = '1 ORE => 1 FUEL'
      factory = described_class.new(example)
      expect(factory.required_ore).to eq(1)
    end

    it 'handles many ore required for one fuel' do
      example = '10 ORE => 1 FUEL'
      factory = described_class.new(example)
      expect(factory.required_ore).to eq(10)
    end

    it 'handles multiples' do
      example = '10 ORE => 1 FUEL'
      factory = described_class.new(example)
      expect(factory.required_ore(2)).to eq(20)
    end

    it 'handles a simple two-line example' do
      example = "5 ORE => 1 A\n1 A => 1 FUEL"
      factory = described_class.new(example)
      expect(factory.required_ore).to eq(5)
    end

    it 'handles a more complicated two-line example' do
      example = "5 ORE => 2 A\n4 A => 1 FUEL"
      factory = described_class.new(example)
      expect(factory.required_ore).to eq(10)
    end

    it 'handles two ingredients for fuel' do
      example = <<~EXAMPLE
        5 ORE => 2 A
        2 ORE => 1 B
        4 A, 2 B => 1 FUEL
      EXAMPLE
      factory = described_class.new(example)
      expect(factory.required_ore).to eq(14)
    end

    it 'handles a dependent ingredient' do
      example = <<~EXAMPLE
        5 ORE => 2 A
        2 A => 1 B
        4 A, 2 B => 1 FUEL
      EXAMPLE
      factory = described_class.new(example)
      expect(factory.required_ore).to eq(20)
    end

    it 'handles excess' do
      example = "5 ORE => 4 A\n2 A => 1 FUEL"
      factory = described_class.new(example)
      expect(factory.required_ore).to eq(5)
    end

    it 'distributes leftovers' do
      example = <<~EXAMPLE
        5 ORE => 3 A
        2 A => 1 B
        1 A, 2 B => 1 FUEL
      EXAMPLE
      factory = described_class.new(example)
      expect(factory.required_ore).to eq(5)
    end
  end
end
