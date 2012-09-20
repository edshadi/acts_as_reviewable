ActiveRecord::Schema.define :version => 0 do
  create_table :reviews do |r|
    r.string      :title,       :default => ""
    r.text        :review
    r.integer     :status
    r.references  :reviewable,  :polymorphic => true
    r.integer     :reviewer,    :null => false

    t.timestamps
  end
  create_table :reviewables do |r|
    r.string :name
  end
end
