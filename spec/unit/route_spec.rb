# frozen_string_literal: true

require_relative '../../lib/route.rb'
RSpec.describe Bus do
  before do
    @route_one = Route.new(1, 2, 3, 4)
    @route_two = Route.new(4, 5, 6, 7)
    @route_three = Route.new(1, 2, 3, 4)
  end

  describe '#==' do
    it 'should compare two routes and return false' do
      expect(@route_one == @route_two).to eq(false)
    end
    it 'should compare two routes and return true' do
      expect(@route_one == @route_three).to eq(true)
    end
  end

  describe '#to_s' do
    it 'should return string with route' do
      expect(@route_one.to_s).to eq('Route number: 1; Route length: 2; Number of stops: 4; Required number of buses: 3')
    end
  end
end
