class Song < ActiveRecord::Base
  belongs_to :user
  has_many :upvotes
  has_many :reviews

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

  def reviewed_by?(user)
    user && self.reviews.where("user_id = #{user.id}").exists?
  end

  def upvoted_by?(user)
    user && self.upvotes.where("user_id = #{user.id}").exists?
  end

end