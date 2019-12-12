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

  # rubocop:disable Naming/MethodParameterName
  def initialize(x, y)
    @x = x
    @y = y
  end
  # rubocop:enable Naming/MethodParameterName

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

  def btw?(num, boundary1, boundary2)
    num.between?(boundary1, boundary2) || num.between?(boundary2, boundary1)
  end

  def intersection(vec)
    # assuming that lines are not overlapping for now...
    if horizontal? && vec.vertical?
      if btw?(start_point.y, vec.start_point.y, vec.end_point.y) &&
         btw?(vec.start_point.x, start_point.x, end_point.x)
        Point.new(start_point.y, vec.start_point.x)
      end
    elsif vertical? && vec.horizontal?
      if btw?(start_point.x, vec.start_point.x, vec.end_point.x) &&
         btw?(vec.start_point.y, start_point.y, end_point.y)
        Point.new(start_point.x, vec.start_point.y)
      end
    end
  end

  def to_s
    "#{start_point} -> #{end_point}"
  end
end

# Represents all the points touched by the wire
class Wire
  attr_reader :path

  ORIGIN = Point.new(0, 0)

  def initialize
    @path = []
  end

  def current_location
    path.last
  end

  def extend(move)
    @path << Vector.new(end_point, end_point.extend(move))
  end

  def end_point
    return ORIGIN if path.empty?

    path.last.end_point
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
end

contents = File.readlines(ARGV[0])

moves_list = contents.map do |line|
  line.strip.split(',').map do |entry|
    Move.new(entry)
  end
end

wires = moves_list.map do |moves|
  wire = Wire.new
  moves.each do |move|
    wire.extend(move)
  end
  wire
end

cross_list = wires[0].crosses(wires[1])

distance_list = cross_list.map(&:manhattan_distance)

puts "Closest cross is #{distance_list.min}"
