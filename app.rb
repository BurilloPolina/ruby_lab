# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader' if development?
require_relative 'lib/bus_list'
require_relative 'lib/route_list'
require_relative 'lib/bus'
require_relative 'lib/route'
require_relative 'lib/validating'

helpers Validating

set :bind, '0.0.0.0'

configure do
  set :bus_list, BusList.init_from_file
  set :route_list, RouteList.init_from_file
  set :status_list, %w[Work Stand Repair]
end

get '/' do
  @bus_list = settings.bus_list

  erb :index
end

get '/bus/params/:index' do
  @bus = settings.bus_list.find_bus_by_number(params[:index].to_i)
  @status_list = settings.status_list
  @route_list = settings.route_list

  erb :bus
end

post '/bus/params/:index' do
  @bus_list = settings.bus_list
  @bus_list.set_new_params(params[:index].to_i, params['status'], params['number_route'].to_i)

  redirect '/'
end

get '/bus/delete/:index' do
  @bus_list = settings.bus_list
  @bus_list.delete_bus_by_number(params[:index].to_i)

  redirect '/'
end

get '/bus/new' do
  @route_list = settings.route_list
  @status_list = settings.status_list
  @errors = []

  erb :new_bus
end

post '/bus/new' do
  @route_list = settings.route_list
  @errors = Validating.check_new_bus(params, settings.bus_list)
  @status_list = settings.status_list
  return erb :new_bus unless @errors.empty?

  new_bus = Bus.new(params['number_bus'].to_i,
                    params['petrol'].to_f, params['first_name'], params['last_name'], params['number_route'].to_i,
                    params['status'])
  settings.bus_list.push(new_bus)

  redirect '/'
end

get '/routes' do
  @route_list = settings.route_list

  erb :routes
end

get '/routes/new' do
  @errors = []

  erb :new_route
end

post '/routes/new' do
  @errors = Validating.check_new_route(params, settings.route_list)
  return erb :new_route unless @errors.empty?

  new_route = Route.new(params['number'].to_i,
                        params['length'].to_i,
                        params['number_of_buses'].to_i,
                        params['number_of_stops'].to_i)
  settings.route_list.push(new_route)

  redirect '/routes'
end

get '/routes/bus_list/:index' do
  bus_list = settings.bus_list
  @route = settings.route_list.find_route_by_number(params[:index].to_i)
  @work_list = []
  @stand_list = []
  @repair_list = []
  @buses_on_route = bus_list.buses_on_the_route(@route.number)

  bus_list.each do |bus|
    next unless bus.number_route == @route.number

    case bus.status
    when 'Work'
      @work_list.push(bus)
    when 'Stand'
      @stand_list.push(bus)
    when 'Repair'
      @repair_list.push(bus)
    end
  end

  erb :route_view
end

get '/routes/delete/:index' do
  @route_list = settings.route_list
  @status_list = settings.status_list
  @route = @route_list.find_route_by_number(params[:index].to_i)

  erb :route_delete
end

post '/routes/delete/:index' do
  @route_list = settings.route_list
  route = @route_list.find_route_by_number(params[:index].to_i)
  buses_on_route = settings.bus_list.find_buses_by_route(route)
  buses_on_route.each do |bus|
    bus.number_route = params['number_route'].to_i
    bus.status = params['status']
  end

  @route_list.delete_route(route)

  redirect '/routes'
end

get '/search' do
  @find_drivers = []

  erb :search_driver
end

post '/search' do
  @route_list = settings.route_list
  @find_drivers = settings.bus_list.find_drivers_by_last_name(params['last_name'])

  return erb :search_driver
end

get '/petrol' do
  @route_list = settings.route_list
  @bus_list = settings.bus_list
  erb :petrol
end
