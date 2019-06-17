class User < ActiveRecord::Base

  has_secure_password
  has_many :ratings

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, uniqueness: { case_sensitive: false } 

  def self.authenticate_with_credentials(email, password)
    user = self.find_by_email(email.gsub(/\s+/, '').downcase)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end
end
