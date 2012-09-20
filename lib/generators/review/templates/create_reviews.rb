class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |r|
      r.string      :title,       :default => ""
      r.text        :review
      r.integer     :status
      r.references  :reviewable,  :polymorphic => true
      r.integer     :reviewer_id

      r.timestamps
    end

    add_index :reviews, :reviewable_type
    add_index :reviews, :reviewable_id
  end
end
