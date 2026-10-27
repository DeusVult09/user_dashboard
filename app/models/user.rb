class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :email, uniqueness: true 
  normalizes :email, with: -> email { email.strip.downcase }
end
