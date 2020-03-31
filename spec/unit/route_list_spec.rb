# frozen_string_literal: true

require_relative '../../lib/route.rb'
require_relative '../../lib/route_list.rb'
RSpec.describe RouteList do
  before do
    @route_one = Route.new(1, 2, 3, 4)
    @route_two = Route.new(2, 3, 4, 5)
    @route_three = Route.new(3, 4, 5, 6)
    @route_list = RouteList.new
    @route_list.push(@route_one)
    @route_list.push(@route_two)
    @second_route_list = RouteList.init_from_file
  end

  describe '#find_route_by_number' do
    it 'should return route with specific number' do
      expect(@route_list.find_route_by_number(1)).to eq(@route_one)
    end
    it 'should return nil' do
      expect(@route_list.find_route_by_number(4)).to eq(nil)
    end
  end

  describe '#delete_route' do
    it 'should delete route from list' do
      expect(@route_list.delete_route(@route_two)).to eq(@route_two)
    end
    it 'should return nil' do
      expect(@route_list.delete_route(@route_three)).to eq(nil)
    end
  end
end
