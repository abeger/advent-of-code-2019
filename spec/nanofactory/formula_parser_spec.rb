RSpec.describe Nanofactory::FormulaParser do
  describe '#parse' do
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

    it 'parses formula text correctly' do
      parser = described_class.new(simple_example)

      expected_hash = {
        'A' => { qty: 10, ingredients: [{ chemical: 'ORE', qty: 10 }] },
        'B' => { qty: 1, ingredients: [{ chemical: 'ORE', qty: 1 }] },
        'C' => { qty: 1, ingredients: [{ chemical: 'A', qty: 7 }, { chemical: 'B', qty: 1 }] },
        'D' => { qty: 1, ingredients: [{ chemical: 'A', qty: 7 }, { chemical: 'C', qty: 1 }] },
        'E' => { qty: 1, ingredients: [{ chemical: 'A', qty: 7 }, { chemical: 'D', qty: 1 }] },
        'FUEL' => { qty: 1, ingredients: [{ chemical: 'A', qty: 7 }, { chemical: 'E', qty: 1 }] }
      }
      expect(parser.parse).to eq(expected_hash)
    end
  end
end
