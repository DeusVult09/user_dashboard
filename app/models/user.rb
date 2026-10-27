class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true 
  normalizes :email, with: -> email { email.strip.downcase }

  enum :status, { active: "active", blocked: "blocked" }, validate: true
end
