# frozen_string_literal: true

module SpaceImageFormat
  # Represents a layer of a Photo
  class Layer
    attr_reader :data_array, :width, :height

    def initialize(data_array, width, height)
      @data_array = data_array
      @width = width
      @height = height
    end

    def rows
      data_array.each_slice(width)
    end

    def digit_count(digit)
      data_array.count { |char| char == digit }
    end
  end
end
