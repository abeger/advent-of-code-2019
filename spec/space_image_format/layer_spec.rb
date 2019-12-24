# frozen_string_literal: true

RSpec.describe SpaceImageFormat::Layer do
  describe '#rows' do
    it 'breaks a layer string into rows' do
      data_string = %w[1 2 3 4 5 6]
      layer = described_class.new(data_string, 3, 2)
      expect(layer.rows).to match_array([%w[1 2 3], %w[4 5 6]])
    end
  end

  describe '#digit_count' do
    it 'counts the number of specific digits in the data' do
      data_string = %w[1 0 3 3 0 3]
      layer = described_class.new(data_string, 3, 2)
      expect(layer.digit_count('0')).to eq(2)
      expect(layer.digit_count('1')).to eq(1)
      expect(layer.digit_count('2')).to eq(0)
      expect(layer.digit_count('3')).to eq(3)
    end
  end
end
