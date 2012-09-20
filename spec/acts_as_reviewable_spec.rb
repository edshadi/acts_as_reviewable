require 'spec_helper'

describe ActsAsReviewable do
  before do
    @model = Reviewable.create :name => "sweet model"
  end
  it "creates a Review for the model that acts_as_reviewable" do
    expect {
      @model.reviews.create :title => "", :review => "nice work"
      @model.reviews.first.reviewer = @user
      @model.reviews.count.should eql 1
      @model.reviews.first.review.should eq "nice work"
    }.to change(Review, :count).by(1)
  end

  it "finds a review by user" do
    review = @model.reviews.create :title => "", :review => "nice work", :reviewer => @user
    @user.reviews.should eq [review]
    Review.find_reviews_by(@user).should eq [review]
  end

  it "finds reviews for a revieweable" do
    review = @model.reviews.create :title => "", :review => "nice work", :reviewer => @user
    @model.reviews.should eq [review]
    Review.find_reviews_for(@model).should eq [review]
  end

  it "creates a review" do
    review = Review.new :title => "", :review => "nice work", :reviewer => @user, :reviewable => @model
    expect {
      review.save
    }.to change(Review, :count).by(1)

    @model.reviews.should eq [review]
    Review.find_reviews_for(@model).should eq [review]
  end

end
