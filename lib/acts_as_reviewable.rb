require 'active_record'
module ActsAsReviewable
  module Review
    def find_review_by reviewer
      where(:reviewer => reviewer).order("created_at DESC")
    end

    def find_review_for reviewable
      where(["reviewable_type = ? and reviewable_id = ?", reviewable.class.name, reviewable.id]).order("created_at DESC")
    end
  end

  module Reviewable
    module ClassMethods
      def acts_as_reviewable
        has_many :reviews, {:as => :reviewable, :dependent => :destroy}
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActsAsReviewable::Reviewable)
