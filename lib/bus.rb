# frozen_string_literal: true

# a base class for bus
class Bus
  attr_reader :number_bus, :petrol, :first_name, :last_name
  attr_accessor :status, :number_route

  def initialize(number_bus, petrol, first_name, last_name, number_route, status)
    @number_bus = number_bus
    @petrol = petrol
    @first_name = first_name
    @last_name = last_name
    @number_route = number_route
    @status = status
  end

  def ==(other)
    number_bus == other.number_bus &&
      petrol == other.petrol &&
      first_name == other.first_name &&
      last_name == other.last_name &&
      number_route == other.number_route &&
      status == other.status
  end

  def to_s
    "Bus number: #{number_bus}; Route number: #{number_route};" \
      " Petrol consumption: #{petrol}; Driver: #{first_name} #{last_name};" \
      " Status: #{status}"
  end
end
