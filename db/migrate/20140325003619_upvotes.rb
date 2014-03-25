class Upvotes < ActiveRecord::Migration
  def change
     create_table :upvotes do |t|
      t.integer :user_id
      t.integer :song_id
      t.timestamps #created_at & updated_at
    end
  end
end
