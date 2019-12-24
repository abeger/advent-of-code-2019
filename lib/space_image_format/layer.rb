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
      @rows ||= data_array.each_slice(width).to_a
    end

    def pixel(x, y)
      # puts "#{x}, #{y}"
      raise IndexError if y >= rows.size || x >= rows[0].size

      rows[y][x]
    end

    def digit_count(digit)
      data_array.count { |char| char == digit }
    end
  end
end
