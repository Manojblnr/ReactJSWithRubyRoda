#  CORS
#  This file is responsible for running the server than it will search routes to run the app
begin
    require_relative '../../.env.rb'
rescue => exception
    puts exception.message
end

require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'].to_sym)



disable :show_exceptions
disable :logging
disable :dump_errors

# This part will access all the type routes like localhost and domain also access all the methods
require_relative 'routes'

builder = Rack::Builder.new do
	use Rack::Cors do
		allow do
			origins '*'
			resource '*', :headers => :any, :methods => [:get, :post, :put, :delete, :options]
		end
	end

	use Rack::Reloader if ENV['RACK_ENV'] == 'development'
	run App.app
end

run builder.to_app

