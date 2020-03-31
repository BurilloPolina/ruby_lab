# frozen_string_literal: true

require_relative 'route'
require 'csv'

# route list
class RouteList
  attr_reader :route_list

  def initialize
    @route_list = []
  end

  def self.init_from_file
    list = RouteList.new
    list.read_from_file(File.expand_path('../data/route_list.csv', __dir__))
    list
  end

  def read_from_file(filename)
    CSV.foreach(filename, headers: true) do |row|
      @route_list.push(Route.new(row['number'].to_i,
                                 row['length'].to_i,
                                 row['number_of_buses'].to_i,
                                 row['number_of_stops'].to_i))
    end
  end

  def find_route_by_number(number)
    @route_list.each do |route|
      return route if route.number == number
    end

    nil
  end

  def delete_route(element)
    @route_list.delete(element) if @route_list.include?(element)
  end

  def push(element)
    @route_list.push(element)
  end

  def each
    return enum_for(:each) unless block_given?

    @route_list.each do |route|
      yield route
    end
  end
end
