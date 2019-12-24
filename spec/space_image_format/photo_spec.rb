# frozen_string_literal: true

RSpec.describe SpaceImageFormat::Photo do
  let(:simple_data_string) { '123456789012' }

  describe '#num_layers' do
    it 'correctly determines number of layers' do
      photo = described_class.new(simple_data_string, 3, 2)
      expect(photo.num_layers).to eq(2)
    end
  end

  describe '#layers' do
    it 'splits the string into Layers' do
      photo = described_class.new(simple_data_string, 3, 2)
      layers = photo.layers
      expect(layers.count).to eq(2)
      expect(layers[0].rows).to match_array([%w[1 2 3], %w[4 5 6]])
      expect(layers[1].rows).to match_array([%w[7 8 9], %w[0 1 2]])
    end
  end
end
