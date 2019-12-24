# frozen_string_literal: true

RSpec.describe SpaceImageFormat::Layer do
  describe '#rows' do
    it 'breaks a layer array into rows' do
      data_array = %w[1 2 3 4 5 6]
      layer = described_class.new(data_array, 3, 2)
      expect(layer.rows).to match_array([%w[1 2 3], %w[4 5 6]])
    end
  end

  describe '#digit_count' do
    it 'counts the number of specific digits in the data' do
      data_array = %w[1 0 3 3 0 3]
      layer = described_class.new(data_array, 3, 2)
      expect(layer.digit_count('0')).to eq(2)
      expect(layer.digit_count('1')).to eq(1)
      expect(layer.digit_count('2')).to eq(0)
      expect(layer.digit_count('3')).to eq(3)
    end
  end

  describe '#pixel' do
    it 'returns value at specific coordinates' do
      data_array = %w[1 2 3 4 5 6]
      layer = described_class.new(data_array, 3, 2)
      expect(layer.pixel(0, 0)).to eq('1')
      expect(layer.pixel(0, 1)).to eq('4')
      expect(layer.pixel(1, 0)).to eq('2')
      expect(layer.pixel(1, 1)).to eq('5')
      expect(layer.pixel(2, 0)).to eq('3')
      expect(layer.pixel(2, 1)).to eq('6')
    end
  end
end
