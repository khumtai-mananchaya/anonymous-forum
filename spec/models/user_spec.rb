require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with an username, email, and password" do
    user = User.new(
       username: "TestingFoo",
       email:      "tester@example.com",
       password:   "dottle-nouveau-pavilion-tights-furze",
    )
    expect(user).to be_valid
    end

  it "is invalid without an username" do
    user = User.new(username: nil)
    expect(user).to_not be_valid
  end

  it "is invalid without an email" do
    user = User.new(email: nil)
    expect(user).to_not be_valid
  end

  it "is invalid without a password" do
    user = User.new(password: nil)
    expect(user).to_not be_valid
  end

  it "is invalid with a duplicate email address"

  it "is invalid with wrong confirmation password"
end
