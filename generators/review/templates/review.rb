class Review < ActiveRecord::Base
  include ActsAsReviewable::Review

  belongs_to :reviewable, :polymorphic => true

end
