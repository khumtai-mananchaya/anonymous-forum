require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with an username, email, and password" do
    user = User.new(
       username: "TestingFoo",
       email:      "tester@example.com",
       password:   "randompasswordhere",
    )
    user.valid?
    end

  it "is invalid without an username" do
    user = User.new(username: nil)
    user.valid?
    expect(user.errors[:username]).to include("can't be blank")
  end

  it "is invalid without an email" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a password" do
    user = User.new(password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    User.create(
        username:  "testing_foo",
        email:      "testing@gmail.com",
        password:   "randompasswordhere",
    )
    user = User.new(
        username:  "Tester",
        email:      "testing@gmail.com",
        password:   "dottle-nouveau-pavilion-tights-furze",
    )
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end
end
