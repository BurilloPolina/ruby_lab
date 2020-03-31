# frozen_string_literal: true

require_relative 'bus_list'
require_relative 'route_list'

# Module for validate instances
module Validating
  def self.validate_value(value)
    return true if value.positive?

    false
  end

  def self.validate_name(name)
    return true if name =~ /^[a-zA-Z]*$/

    false
  end

  def self.check_new_bus(params, bus_list)
    @errors = []
    bus_number = bus_list.find_bus_by_number(params['number_bus'].to_i)
    @errors.append('A bus with this number already exists') unless bus_number.nil?
    @errors.append('Bus number must be greater than 0') unless validate_value(params['number_bus'].to_i)
    @errors.append('Route number must be greater than 0') unless validate_value(params['number_route'].to_i)
    @errors.append('Petrol consumption cannot be negative or equal to 0') unless validate_value(params['petrol'].to_f)
    @errors.append('Driver name may contain only letters') unless validate_name(params['first_name'])
    @errors.append('Driver last name may contain only letters') unless validate_name(params['last_name'])
    @errors
  end

  def self.check_new_route(params, route_list)
    @errors = []
    number_route = route_list.find_route_by_number(params['number'].to_i)
    @errors.append('A route with this number already exists') unless number_route.nil?
    @errors.append('Route number must be greater than 0') unless validate_value(params['number'].to_i)
    unless validate_value(params['length'].to_i)
      @errors.append('The length of the route can not be negative or equal to 0')
    end
    unless validate_value(params['number_of_buses'].to_i)
      @errors.append('The required number of buses on the route must be greater than 0')
    end
    @errors.append('The number of stops must be greater than 0') unless validate_value(params['number_of_stops'].to_i)
    @errors
  end
end
