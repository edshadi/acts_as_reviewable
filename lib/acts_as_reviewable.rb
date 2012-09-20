require 'active_record'
module ActsAsReviewable

  module Review
    def self.included(receiver)
      receiver.extend ClassMethods
    end

    module ClassMethods
      def find_reviews_by reviewer
        where(:reviewer_id => reviewer.id).order("created_at DESC")
      end

      def find_reviews_for reviewable
        where(["reviewable_type = ? and reviewable_id = ?", reviewable.class.name, reviewable.id]).order("created_at DESC")
      end
    end

  end

  module Reviewable
    def self.included(receiver)
      receiver.extend ClassMethods
    end

    module ClassMethods
      def acts_as_reviewable
        has_many :reviews, {:as => :reviewable, :dependent => :destroy}
      end
    end
  end
end

ActiveRecord::Base.send(:include, ActsAsReviewable::Reviewable)
