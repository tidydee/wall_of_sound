class AddSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :artist
      t.string :genre
      t.string :url
      t.integer :user_id
      t.integer :vote_count, :default =>0 
      t.timestamps #created_at & updated_at 
    end
  end
end


