require 'rubygems'
require File.expand_path('../../lib/acts_as_reviewable', __FILE__)

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.establish_connection(:adapter => "sqlite3", :database => "acts_as_reviewable")

RSpec.configure do |config|
  # Use color in STDOUT
  config.color_enabled = true

  # Use color not only in STDOUT but also in pagers and files
  config.tty = true

  # Use the specified formatter
  config.formatter = :documentation # :progress, :html, :textmate

  config.before(:each) do
    setup_reviews
    setup_test_models
    @user = User.create :name => "Awesome User"
  end
  config.after(:each) do
    teardown
  end

end

def setup_reviews
  require File.expand_path(File.dirname(__FILE__) + '/../lib/generators/review/templates/create_reviews')
  CreateReviews.up
  load(File.expand_path(File.dirname(__FILE__) + '/../lib/generators/review/templates/review.rb'))
end

def setup_test_models
  load(File.expand_path(File.dirname(__FILE__) + '/schema.rb'))
  load(File.expand_path(File.dirname(__FILE__) + '/models.rb'))
end

def teardown
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end
