# frozen_string_literal: true

RSpec.describe Intcode::Descriptor do
  describe '#code' do
    it 'pads correctly' do
      desc = described_class.new('123')
      expect(desc.code).to eq('00123')
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
  end

  describe '#immediate_param?' do
    it 'parses which parameters are immediate' do
      desc = described_class.new('11045')
      expect(desc.immediate_param?(1)).to be false
      expect(desc.immediate_param?(2)).to be true
      expect(desc.immediate_param?(3)).to be true
    end
  end
end
