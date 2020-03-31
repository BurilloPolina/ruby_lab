# frozen_string_literal: true

# a base class for bus route
class Route
  attr_reader :number, :length, :number_of_buses, :number_of_stops

  def initialize(number, length, number_of_buses, number_of_stops)
    @number = number
    @length = length
    @number_of_buses = number_of_buses
    @number_of_stops = number_of_stops
  end

  def ==(other)
    number == other.number &&
      length == other.length &&
      number_of_buses == other.number_of_buses &&
      number_of_stops == other.number_of_stops
  end

  def to_s
    "Route number: #{number}; Route length: #{length};" \
      " Number of stops: #{number_of_stops};" \
      " Required number of buses: #{number_of_buses}"
  end
end
