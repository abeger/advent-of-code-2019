# frozen_string_literal: true

RSpec.describe Nanofactory::Bank do
  describe '#deposit' do
    it 'deposits a chemical' do
      bank = described_class.new
      bank.deposit('A', 15)
      bank.deposit('B', 1)
      expect(bank.contents).to eq('A' => 15, 'B' => 1)
    end

    it 'adds more' do
      bank = described_class.new
      bank.deposit('A', 15)
      bank.deposit('A', 5)
      expect(bank.contents).to eq('A' => 20)
    end

    it 'raises when ore is deposited' do
      bank = described_class.new
      expect do
        bank.deposit('ORE', 6)
      end.to raise_error(ArgumentError)
    end
  end

  describe '#withdraw' do
    let(:bank) do
      described_class.new.tap do |b|
        b.deposit('A', 5)
        b.deposit('B', 4)
      end
    end

    it 'withdraws a chemical' do
      bank.withdraw('A', 2)
      expect(bank.contents).to eq('A' => 3, 'B' => 4)
    end

    it 'zeros out a chemical' do
      bank.withdraw('A', 5)
      expect(bank.contents).to eq('B' => 4)
    end

    it 'withdraws ore' do
      expect(bank.ore_consumed).to eq(0)
      bank.withdraw('ORE', 40)
      expect(bank.ore_consumed).to eq(40)
      expect(bank.contents).to eq('A' => 5, 'B' => 4)
    end

    it 'raises when out of funds' do
      expect do
        bank.withdraw('A', 6)
      end.to raise_error(Nanofactory::InsufficientFundsException)
    end
  end
end
