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
    it 'solves a simple one-line example' do
      example = '1 ORE => 1 FUEL'
      factory = described_class.new(example)
#      expect(factory.required_ore).to eq(1)
      expect(factory.requirements('FUEL', 1)).to eq({ ore: 1, output: { 'FUEL' => 1 } })
    end

    it 'handles many ore required for one fuel' do
      example = '10 ORE => 1 FUEL'
      factory = described_class.new(example)
      expect(factory.requirements('FUEL', 1)).to eq({ ore: 10, output: { 'FUEL' => 1 } })
    end

    it 'handles multiples' do
      example = '10 ORE => 1 FUEL'
      factory = described_class.new(example)
      expect(factory.requirements('FUEL', 2)).to eq({ ore: 20, output: { 'FUEL' => 2 } })
    end

    it 'handles a simple two-line example' do
      example = "5 ORE => 1 A\n1 A => 1 FUEL"
      factory = described_class.new(example)
      expect(factory.requirements('FUEL', 1)).to eq({ ore: 5, output: { 'FUEL' => 2 } })
    end

    it 'handles a more complicated two-line example' do
      example = "5 ORE => 2 A\n4 A => 1 FUEL"
      factory = described_class.new(example)
      expect(factory.requirements('FUEL', 1)).to eq({ ore: 10, output: { 'FUEL' => 1 } })
    end

    it 'handles two ingredients for fuel' do
      example = <<~EXAMPLE
        5 ORE => 2 A
        2 ORE => 1 B
        4 A, 2 B => 1 FUEL
      EXAMPLE
      factory = described_class.new(example)
      expect(factory.requirements('FUEL', 1)).to eq({ ore: 14, output: { 'FUEL' => 1 } })
    end

    it 'handles a dependent ingredient' do
      example = <<~EXAMPLE
        5 ORE => 2 A
        2 A => 1 B
        4 A, 2 B => 1 FUEL
      EXAMPLE
      factory = described_class.new(example)
      expect(factory.requirements('FUEL', 1)).to eq({ ore: 20, output: { 'FUEL' => 1 } })
    end

    it 'handles excess' do
      example = "5 ORE => 4 A\n2 A => 1 FUEL"
      factory = described_class.new(example)
      expect(factory.requirements('FUEL', 1)).to eq({ ore: 5, output: { 'FUEL' => 1, 'A' => 2 } })
    end

    it 'returns results' do
      example = '3 ORE => 2 A'
      factory = described_class.new(example)
      expect(factory.requirements('A', 3)).to eq({ ore: 6, output: { 'A' => 4 } })
    end

    it 'distributes leftovers' do
      example = <<~EXAMPLE
        5 ORE => 3 A
        2 A => 1 B
        1 A, 2 B => 1 FUEL
      EXAMPLE
      factory = described_class.new(example)
      expect(factory.requirements('FUEL', 1)).to eq({ ore: 5, output: { 'FUEL' => 1 } })
    end
  end
end
