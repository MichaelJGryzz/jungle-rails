class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 6 }

  # Class method for authentication
  def self.authenticate_with_credentials(email, password)
    # Normalize email to ensure case-insensitivity and remove any additional spaces
    normalized_email = email.strip.downcase
    
    # Find user by email and authenticate using the provided password
    user = User.find_by(email: normalized_email)
    user && user.authenticate(password) ? user : nil
  end
end
