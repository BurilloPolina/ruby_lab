# frozen_string_literal: true

require_relative '../../lib/bus.rb'
require_relative '../../lib/route.rb'
require_relative '../../lib/bus_list.rb'
require_relative '../../lib/route_list.rb'
RSpec.describe BusList do
  before do
    @bus_one = Bus.new(1, 2, 'Ivan', 'Ivanov', 1, 'Work')
    @bus_two = Bus.new(2, 4, 'Petr', 'Petrov', 2, 'Stand')
    @bus_three = Bus.new(3, 5, 'Egor', 'Egorov', 3, 'Repair')
    @bus_four = Bus.new(1, 2, 'Ivan', 'Ivanov', 2, 'Stand')
    @route_one = Route.new(1, 2, 3, 4)
    @route_two = Route.new(2, 3, 4, 5)
    @route_three = Route.new(3, 4, 5, 6)
    @route_list = RouteList.new
    @route_list.push(@route_one)
    @route_list.push(@route_two)
    @route_list.push(@route_three)
    @test_list = BusList.new
    @test_list.push(@bus_one)
    @test_list.push(@bus_two)
    @second_list = BusList.new
    @second_list.push(@bus_one)
    @second_list.push(@bus_three)
    @third_list = BusList.init_from_file
  end

  describe '#find_bus_by_number' do
    it 'should return bus with equal number' do
      expect(@test_list.find_bus_by_number(1)).to eq(@bus_one)
    end
    it 'should return nil' do
      expect(@test_list.find_bus_by_number(5)).to eq(nil)
    end
  end

  describe '#find_buses_by_route' do
    it 'should return list of buses with specific route' do
      expect(@test_list.find_buses_by_route(@route_one)).to eq([@bus_one])
    end
  end

  describe '#calculate_petrol_cost' do
    it 'should calculate total petrol cost' do
      expect(@test_list.calculate_petrol_cost(@route_list)).to eq(16)
    end
  end

  describe '#find_drivers_by_last_name' do
    it 'should return list of drivers with specific last name' do
      expect(@test_list.find_drivers_by_last_name('Ivanov')).to eq([@bus_one])
    end
  end

  describe '#buses_on_the_route' do
    it 'should calculate count of buses on the route' do
      expect(@test_list.buses_on_the_route(1)).to eq(1)
    end
  end

  describe '#set_new_params' do
    it 'should set new params for bus by number' do
      @second_list.set_new_params(1, 'Stand', 2)
      expect(@second_list.find_bus_by_number(1)).to eq(@bus_four)
    end
  end

  describe '#route_petrol_cost' do
    it 'should calculate petrol cost on the route' do
      expect(@test_list.route_petrol_cost(@route_one)).to eq(4)
    end
  end

  describe '#delete_bus_by_number' do
    it 'should delete bus from list by number' do
      expect(@test_list.delete_bus_by_number(2)).to eq(@bus_two)
    end
  end
end
