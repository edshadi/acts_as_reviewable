class Review < ActiveRecord::Base
  include ActsAsReviewable::Review
  acts_as_review_model :reviewer => 'User'
end
