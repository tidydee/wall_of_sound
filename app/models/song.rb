class Song < ActiveRecord::Base
  belongs_to :user
  has_many :upvotes

  validates :name, 
            presence: true,
            length: { minimum:3 }

  validates :artist,
            presence: true,
            length: { minimum:3 }

  validates :genre,
            presence: true,
            length: { minimum:3 }          

  validates_format_of :url, with: URI.regexp 

end