# frozen_string_literal: true

RSpec.describe Intcode::Command do
  describe '#code' do
    it 'pads correctly' do
      desc = described_class.new('123')
      expect(desc.code).to eq('00123')
    end

    it 'handles ints' do
      desc = described_class.new(23)
      expect(desc.code).to eq('00023')
    end

    it 'handles 1' do
      desc = described_class.new('1')
      expect(desc.code).to eq('00001')
    end
  end

  describe '#opcode' do
    it 'parses out the opcode' do
      desc = described_class.new('11045')
      expect(desc.opcode).to eq(45)
    end

    it 'deals with leading 0' do
      desc = described_class.new('11005')
      expect(desc.opcode).to eq(5)
    end

    it 'handles 1' do
      desc = described_class.new('1')
      expect(desc.opcode).to eq(1)
    end
  end

  describe '#immediate_param?' do
    it 'parses which parameters are immediate' do
      desc = described_class.new('11045')
      expect(desc.immediate_param?(0)).to be false
      expect(desc.immediate_param?(1)).to be true
      expect(desc.immediate_param?(2)).to be true
    end

    it 'works for 1001' do
      desc = described_class.new('1001')
      expect(desc.immediate_param?(0)).to be false
      expect(desc.immediate_param?(1)).to be true
      expect(desc.immediate_param?(2)).to be false
    end
  end

  describe '#relative_param?' do
    it 'parses which parameters are relative' do
      desc = described_class.new('12045')
      expect(desc.relative_param?(0)).to be false
      expect(desc.relative_param?(1)).to be true
      expect(desc.relative_param?(2)).to be false
    end
  end
end
