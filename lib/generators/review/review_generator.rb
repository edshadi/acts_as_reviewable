require 'rails/generators/migration'

class ReviewGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    @acts_as_reviewable ||= File.expand_path("../templates", __FILE__)
  end

  def self.next_migration_number(path)
    Time.now.utc.strftime("%Y%m%d%H%M%S")
  end

  def create_model_file
    template "review.rb", "app/models/review.rb"
    migration_template "create_reviews.rb", "db/migrate/create_reviews.rb"
  end
end
