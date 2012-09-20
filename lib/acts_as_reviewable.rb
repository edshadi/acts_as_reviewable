require 'active_record'
module ActsAsReviewable

  module Review
    require 'acts_as_tree'

    def self.included(receiver)
      receiver.extend ClassMethods
      receiver.send :include, ActsAsTree
    end

    module ClassMethods
      def acts_as_review_model options={}
        belongs_to :reviewable, :polymorphic => true
        belongs_to :reviewer, :class_name => options[:reviewer] || 'User'
        acts_as_tree
      end

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
