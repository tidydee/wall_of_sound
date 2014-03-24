class AddSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.string :artist
      t.string :genre
      t.string :url
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
