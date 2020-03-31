# frozen_string_literal: true

require_relative 'bus'
require 'csv'

# bus list
class BusList
  attr_reader :bus_list

  def initialize
    @bus_list = []
  end

  def self.init_from_file
    list = BusList.new
    list.read_from_file(File.expand_path('../data/bus_list.csv', __dir__))
    list
  end

  def read_from_file(filename)
    CSV.foreach(filename, headers: true) do |row|
      @bus_list.push(Bus.new(row['number_bus'].to_i, row['petrol'].to_f,
                             row['first_name'], row['last_name'], row['number_route'].to_i,
                             row['status']))
    end
  end

  def find_bus_by_number(number)
    @bus_list.each do |bus|
      return bus if bus.number_bus == number
    end

    nil
  end

  def find_buses_by_route(route)
    finded_buses = []
    @bus_list.each do |bus|
      finded_buses.push(bus) if bus.number_route == route.number
    end

    finded_buses
  end

  def calculate_petrol_cost(route_list)
    cost = 0
    @bus_list.each do |bus|
      route = route_list.find_route_by_number(bus.number_route)
      cost += bus.petrol * route.length
    end

    cost
  end

  def find_drivers_by_last_name(last_name)
    drivers_list = []
    @bus_list.each do |bus|
      drivers_list.append(bus) if bus.last_name.casecmp?(last_name)
    end

    drivers_list
  end

  def buses_on_the_route(number_route)
    count = 0
    @bus_list.each do |bus|
      count += 1 if bus.number_route == number_route
    end

    count
  end

  def set_new_params(number, new_status, new_route)
    bus = find_bus_by_number(number)
    bus.status = new_status
    bus.number_route = new_route
  end

  def route_petrol_cost(route)
    cost = 0
    @bus_list.each do |bus|
      cost += bus.petrol * route.length if bus.number_route == route.number
    end

    cost
  end

  def delete_bus_by_number(number)
    bus = find_bus_by_number(number)
    @bus_list.delete(bus)
  end

  def push(element)
    @bus_list.push(element)
  end

  def each
    return enum_for(:each) unless block_given?

    @bus_list.each do |bus|
      yield bus
    end
  end
end
