# frozen_string_literal: true

module SpaceImageFormat
  # Represents a photo parsed from Space Image Format
  class Photo
    attr_reader :data_string, :width, :height

    def initialize(data_string, width, height)
      @data_string = data_string
      @width = width
      @height = height
    end

    def num_layers
      data_string.length / layer_length
    end

    def layers
      @layers ||= data_string.chars
                             .each_slice(layer_length)
                             .map { |slice| SpaceImageFormat::Layer.new(slice, width, height) }
    end

    def decode
      height.times.map do |y|
        width.times.map do |x|
          color(x, y)
        end.join
      end
    end

    private

    def layer_length
      width * height
    end

    def color(x, y)
      layers.find do |layer|
        %w[0 1].include?(layer.pixel(x, y))
      end.pixel(x, y)
    end
  end
end
