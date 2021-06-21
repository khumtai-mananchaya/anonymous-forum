class User < ApplicationRecord
  #has_many :post
  acts_as_voter
  attr_accessor :password_confirmation
  has_secure_password
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
end
