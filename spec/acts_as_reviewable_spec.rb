require 'spec_helper'

describe ActsAsReviewable do
  let(:model) { Reviewable.create :name => "sweet model" }

  context "#acts_as_reviewable" do
    it "creates a Review for the model that is reviewable" do
      expect {
        model.reviews.create :title => "", :review => "nice work"
        model.reviews.first.reviewer = @user
        model.reviews.count.should eql 1
        model.reviews.first.review.should eq "nice work"
      }.to change(Review, :count).by(1)
    end

    it "creates a review" do
      review = Review.new :title => "", :review => "nice work", :reviewer => @user, :reviewable => model
      expect {
        review.save
      }.to change(Review, :count).by(1)

      model.reviews.should eq [review]
      Review.find_reviews_for(model).should eq [review]
    end
  end

  context "finders" do
    it "finds a review by user" do
      review = model.reviews.create :title => "", :review => "nice work", :reviewer => @user
      @user.reviews.should eq [review]
      Review.find_reviews_by(@user).should eq [review]
    end

    it "finds reviews for a revieweable" do
      review = model.reviews.create :title => "", :review => "nice work", :reviewer => @user
      model.reviews.should eq [review]
      Review.find_reviews_for(model).should eq [review]
    end
  end

  context "#acts_as_tree" do
    it "is the parent" do
      review = Review.create :title => "", :review => "nice work", :reviewer => @user, :reviewable => model
      review.parent.should be_nil
      review.root.should eq review
    end
    it "is has children" do
      parent = Review.create :title => "parent", :review => "nice work", :reviewer => @user, :reviewable => model
      child = Review.create :title => "child", :review => "nice work", :reviewer => @user, :reviewable => model, :parent => parent
      parent.root.should eq parent
      parent.children.should eq [child]
    end
  end

end
