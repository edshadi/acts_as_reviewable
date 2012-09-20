class Reviewable < ActiveRecord::Base
  acts_as_reviewable
end

class User < ActiveRecord::Base
  has_many :reviews, :foreign_key => 'reviewer_id'
end
