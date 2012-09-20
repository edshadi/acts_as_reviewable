ActiveRecord::Schema.define :version => 0 do
  create_table :reviews do |r|
    r.string      :title,       :default => ""
    r.text        :review
    r.integer     :status
    r.references  :reviewable,  :polymorphic => true
    r.integer     :reviewer_id
    r.integer     :parent_id

    r.timestamps
  end

  create_table :reviewables do |r|
    r.string :name
  end

  create_table :users do |u|
    u.string :name
  end
end
