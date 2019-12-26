# frozen_string_literal: true

# represents a move along the grid
class Move
  attr_reader :direction, :distance

  def initialize(entry)
    @direction = entry[0]
    @distance = entry[1..-1].to_i
  end
end

# A point on the grid
class Point
  include Comparable

  attr_reader :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end

  def manhattan_distance
    x.abs + y.abs
  end

  def extend(move)
    case move.direction
    when 'U'
      Point.new(x, y + move.distance)
    when 'D'
      Point.new(x, y - move.distance)
    when 'R'
      Point.new(x + move.distance, y)
    when 'L'
      Point.new(x - move.distance, y)
    end
  end

  # don't care about > <, just ==
  def <=>(other)
    return 0 if x == other.x && y == other.y

    1
  end

  def to_s
    "(#{x}, #{y})"
  end
end

# One segment of wire. Implies direction.
class Vector
  attr_reader :start_point, :end_point

  def initialize(start_point, end_point)
    @start_point = start_point
    @end_point = end_point
  end

  def horizontal?
    start_point.y == end_point.y
  end

  def vertical?
    start_point.x == end_point.x
  end

  # Need these to use between? efficiently
  def sorted_x
    @sorted_x ||= [start_point.x, end_point.x].sort
  end

  def sorted_y
    @sorted_y ||= [start_point.y, end_point.y].sort
  end

  def contains?(point)
    return point.x.between?(sorted_x[0], sorted_x[1]) if point.y == start_point.y

    return point.y.between?(sorted_y[0], sorted_y[1]) if point.x == start_point.x

    false
  end

  def length
    Math.sqrt((start_point.x - end_point.x).abs**2 + (start_point.y - end_point.y).abs**2)
  end

  def intersection(vec)
    # assuming that lines are not overlapping for now...
    cand1 = Point.new(start_point.x, vec.start_point.y)
    return cand1 if vec.contains?(cand1) && contains?(cand1)

    cand2 = Point.new(vec.start_point.x, start_point.y)
    return cand2 if vec.contains?(cand2) && contains?(cand2)

    nil
  end

  def to_s
    "#{start_point} -> #{end_point}"
  end
end

# Represents all the points touched by the wire
class Wire
  ORIGIN = Point.new(0, 0)

  def initialize(move_list)
    @move_list = move_list
  end

  def crosses(wire)
    cross_list = path.map do |p|
      wire.path.map do |w_p|
        w_p.intersection(p)
      end
    end.flatten.compact
    # Skip 0,0
    cross_list.reject { |p| p == ORIGIN }
  end

  def to_s
    path.join(', ')
  end

  def path
    @path ||= lay_out
  end

  def signal_delay(point)
    distance = 0
    path.each do |vector|
      if vector.contains?(point)
        distance += Vector.new(vector.start_point, point).length
        break
      else
        distance += vector.length
      end
    end
    distance
  end

  private

  # Lay out the wire based on a move list
  def lay_out
    layout = []
    @move_list.each do |move|
      end_point = layout.empty? ? ORIGIN : layout.last.end_point
      layout << Vector.new(end_point, end_point.extend(move))
    end
    layout
  end
end

# Methods to perform on a pair of wires
class WirePair
  attr_reader :wire1, :wire2

  def initialize(wire1, wire2)
    @wire1 = wire1
    @wire2 = wire2
  end

  def closest_manhattan_intersection
    manhattan_distances.min
  end

  def lowest_signal_delay
    signal_delays.min
  end

  private

  def manhattan_distances
    intersections.map(&:manhattan_distance)
  end

  def signal_delays
    intersections.map do |int|
      wire1.signal_delay(int) + wire2.signal_delay(int)
    end
  end

  def intersections
    wire1.crosses(wire2)
  end
end

def parse_moves(file_contents)
  file_contents.map do |line|
    line.strip.split(',').map do |entry|
      Move.new(entry)
    end
  end
end

moves_list = parse_moves(File.readlines(ARGV[0]))

wires = moves_list.map do |moves|
  Wire.new(moves)
end

wire_pair = WirePair.new(wires[0], wires[1])

puts "Closest cross is #{wire_pair.closest_manhattan_intersection}"
puts "Lowest signal delay is #{wire_pair.lowest_signal_delay}"
