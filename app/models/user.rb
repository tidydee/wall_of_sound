require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt
  
  has_many :songs
  has_many :upvotes

  validates :email, presence: true
  validates :password, presence: true

 # users.password_hash in the database is a :string

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
  

end