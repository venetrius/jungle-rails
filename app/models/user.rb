class User < ActiveRecord::Base

  has_secure_password
  has_many :ratings

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP } 

end
