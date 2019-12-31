# frozen_string_literal: true

# OK here's some ideas:
# Hull contains a map of x,y coordinate to Panel
# Panel tracks its color and whether it's been painted
# Panel *might* just be a Struct, rather than a full object
# Counting painted panels is just a count of painted? == true
# Drawing the diagram is a little trickier, but just basically sorting the keys
# OR MAYBE we have a hash of y keys to another hash of x keys
# Converting to drawing means get min/max of all x values, then we sort the y
# keys, and print out minx..maxx for each line, filling in gaps with black
# Need to figure out who's in charge of determining move results: Panel or Hull

module PaintingRobot
  # Represents the hull of the ship, keeps track of location
  class Hull
    def initialize
      @x_pos = 0
      @y_pos = 0
    end

    def map
      @map ||= Hash.new do |h, k|
        h[k] = Hash.new { |h2, k2| h2[k2] = Panel.new }
      end
    end

    def move_left
      move_x(-1)
    end

    def move_right
      move_x(1)
    end

    def move_up
      move_y(-1)
    end

    def move_down
      move_y(1)
    end

    def current_location
      map[@y_pos][@x_pos]
    end

    def panels_painted
      map.values.map do |row|
        row.values.count(&:painted?)
      end.sum
    end

    def display
      map.keys.sort.each.map do |row|
        (min_x..max_x).map do |col|
          map[row][col].print
        end.join
      end.join("\n")
    end

    private

    def min_x
      map.values.map do |row|
        row.keys.min
      end.min
    end

    def max_x
      map.values.map do |row|
        row.keys.max
      end.max
    end

    def move_x(amt)
      @x_pos += amt
    end

    def move_y(amt)
      @y_pos += amt
    end
  end
end
