class Reviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :song_id
      t.string :review
      t.timestamps #created_at & updated_at
    end
  end
end
