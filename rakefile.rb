# This file used to excute the commands to the backend

# Responsible for migration from migrations files to database

begin
	require_relative '.env.rb'
rescue LoadError => e
	puts e.message
end

%w(
	yaml
	shellwords
).each { |lib| require lib }

require 'bundler'
Bundler.require(:default, (ENV['RACK_ENV'] || 'development').to_sym)


# ----------------------------- #
# Usage:						#
# to get to latest version		#
# rake migrate					#
# to get to specific version	#
# rake migrate[3]				#
# ----------------------------- #

namespace :db do
	desc "SQLite DB - enter version number or blank for latest"
	task :migrate, [:version] do |t, args|
		Sequel.extension :migration
		db_file = File.expand_path(File.join(ENV['DB_FILE']))
		db = Sequel.connect adapter: 'sqlite', database: db_file
		if args[:version]
			puts "Migrating to version #{args[:version]}"
			Sequel::Migrator.run(db, "server/migrations", target: args[:version].to_i)
		else
			puts "Migrating to latest"
			Sequel::Migrator.run(db, "server/migrations")
		end
	end
end