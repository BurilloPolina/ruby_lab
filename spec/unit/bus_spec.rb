# frozen_string_literal: true

require_relative '../../lib/bus.rb'
RSpec.describe Bus do
  before do
    @bus_one = Bus.new(1, 2, 'Ivan', 'Ivanov', 4, 'Work')
    @bus_two = Bus.new(3, 4, 'Petr', 'Petrov', 5, 'Stand')
    @bus_three = Bus.new(1, 2, 'Ivan', 'Ivanov', 4, 'Work')
  end

  describe '#==' do
    it 'should compare two buses and return false' do
      expect(@bus_one == @bus_two).to eq(false)
    end
    it 'should compare two buses and return true' do
      expect(@bus_one == @bus_three).to eq(true)
    end
  end

  describe '#to_s' do
    it 'should return string with bus' do
      expect(@bus_one.to_s). to eq('Bus number: 1;' \
        ' Route number: 4; Petrol consumption: 2;' \
        ' Driver: Ivan Ivanov; Status: Work')
    end
  end
end
