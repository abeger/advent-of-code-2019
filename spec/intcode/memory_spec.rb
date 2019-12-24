# frozen_string_literal: true

RSpec.describe Intcode::Memory do
  describe '#read' do
    it 'reads from memory' do
      mem = described_class.new([1, 2, 3, 4])
      expect(mem.read(0)).to eq(1)
      expect(mem.read(3)).to eq(4)
    end

    it 'read beyond original memory' do
      mem = described_class.new([1, 2, 3, 4])
      expect(mem.read(6)).to eq(0)
      expect(mem.contents).to match_array([1, 2, 3, 4, 0, 0, 0])
    end

    it 'reads a range' do
      mem = described_class.new([1, 2, 3, 4])
      expect(mem.read(1..2)).to match_array([2, 3])
    end

    it 'reads a range partially beyond original memory' do
      mem = described_class.new([1, 2, 3, 4])
      expect(mem.read(2..5)).to match_array([3, 4, 0, 0])
    end

    it 'reads a range entirely beyond original memory' do
      mem = described_class.new([1, 2, 3, 4])
      expect(mem.read(5..7)).to match_array([0, 0, 0])
    end
  end

  describe '#write' do
    it 'writes to memory' do
      mem = described_class.new([1, 2, 3, 4])
      mem.write(0, 89)
      mem.write(3, -2)
      expect(mem.contents).to match_array([89, 2, 3, -2])
    end

    it 'writes beyond original memory' do
      mem = described_class.new([1, 2, 3, 4])
      mem.write(8, 7)
      expect(mem.contents).to match_array([1, 2, 3, 4, 0, 0, 0, 0, 7])
    end
  end
end
