require 'rubygems'
require File.expand_path('../../lib/acts_as_reviewable', __FILE__)

db_name = ENV['DB'] || 'sqlite3'
database_yml = File.expand_path('../database.yml', __FILE__)

active_record_configuration = YAML.load_file(database_yml)
ActiveRecord::Base.configurations = active_record_configuration
config = ActiveRecord::Base.configurations[db_name]
ActiveRecord::Base.establish_connection(db_name)
ActiveRecord::Base.connection

ActiveRecord::Base.silence do
  ActiveRecord::Migration.verbose = false

  load(File.dirname(__FILE__) + '/schema.rb')
  load(File.dirname(__FILE__) + '/models.rb')
end

RSpec.configure do |config|
  config.after(:each) do
    ActiveRecord::Base.connection.execute "DELETE FROM reviewables"
  end
end
