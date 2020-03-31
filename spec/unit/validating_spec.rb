# frozen_string_literal: true

require_relative '../../lib/validating.rb'
require_relative '../../lib/bus.rb'
require_relative '../../lib/route.rb'
RSpec.describe Validating do
  before do
    @bus_params = { 'number_bus' => '10', 'number_route' => '2',
                    'petrol' => '3', 'first_name' => 'Ivan', 'last_name' => 'Ivanov', 'status' => 'work' }
    @s_bus_params = { 'number_bus' => '10', 'number_route' => '2',
                      'petrol' => '0', 'first_name' => 'Ivan', 'last_name' => 'Ivanov', 'status' => 'stand' }
    @route_params = { 'number' => '3', 'length' => '10', 'number_of_buses' => '3', 'number_of_stops' => 4 }
    @s_route_params = { 'number' => '3', 'length' => '0', 'number_of_buses' => '0', 'number_of_stops' => 0 }
    @bus_list = BusList.new
    @route_list = RouteList.new
  end

  describe '#validate_value' do
    it 'should return true if value os positive' do
      expect(Validating.validate_value(3)).to eq(true)
    end
    it 'should return false if value not positive' do
      expect(Validating.validate_value(-2)).to eq(false)
    end
  end

  describe '#validate_name' do
    it 'should return true if name matches the regular expression' do
      expect(Validating.validate_name('Vasya')).to eq(true)
    end
    it 'should return false if name doesnt matches the regular expression' do
      expect(Validating.validate_name('Vas1')).to eq(false)
    end
  end

  describe '#check_new_bus' do
    it 'should return empty list of errors' do
      expect(Validating.check_new_bus(@bus_params, @bus_list)).to eq([])
    end
    it 'should return list of errors' do
      expect(Validating
        .check_new_bus(@s_bus_params, @bus_list))
        .to eq(['Petrol consumption cannot be negative or equal to 0'])
    end
  end

  describe '#check_new_route' do
    it 'should return empty list of errors' do
      expect(Validating.check_new_route(@route_params, @route_list)).to eq([])
    end
    it 'should return list of errors' do
      expect(Validating
        .check_new_route(@s_route_params, @route_list))
        .to eq(['The length of the route can not be negative or equal to 0',
                'The required number of buses on the route must be greater than 0',
                'The number of stops must be greater than 0'])
    end
  end
end
