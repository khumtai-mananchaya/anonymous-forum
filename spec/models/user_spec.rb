require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has a valid factory' do
    expect(FactoryBot.build(:user)).to be_valid
  end

  it "is invalid without an username" do
    user = FactoryBot.build(:user, username: nil)
    user.valid?
    expect(user.errors[:username]).to include("can't be blank")
  end

  it "is invalid without an email" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid without a password" do
    user = FactoryBot.build(:user, password: nil)
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid with a duplicate email address" do
    FactoryBot.create(:user, email: "testing@gmail.com")
    user = FactoryBot.build(:user, email: "testing@gmail.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "is invalid with a duplicate username" do
    FactoryBot.create(:user, username: "duplicate")
    user = FactoryBot.build(:user, username: "duplicate")
    user.valid?
    expect(user.errors[:username]).to include("has already been taken")
   end
end
