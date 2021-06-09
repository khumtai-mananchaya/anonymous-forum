class User < ApplicationRecord
  attr_accessor :email, :username, :password, :password_confirmation
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: 'Invalid email' }
end
